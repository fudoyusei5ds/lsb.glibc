/* Skeleton for test programs.
   Copyright (C) 1998-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Ulrich Drepper <drepper@cygnus.com>, 1998.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */
#ifndef _GNU_SOURCE
#   define _GNU_SOURCE
#endif

#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <malloc.h>
#include <paths.h>
#include <search.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <sys/param.h>
#include <time.h>
// #include "test-skeleton.c"   // 奇怪,爲何要引用自己?


// 測試函數被稱爲do_test並且它以argc,argv爲參數進行調用.這個宏可以在測試用例中進行覆蓋
#ifndef TEST_FUNCTION
#   define TEST_FUNCTION do_test (argc, argv)
#endif

#ifndef TEST_DATA_LIMIT
#   define TEST_DATA_LIMIT (64 << 20) // 運行時的數據字節大小限制
#endif

#ifndef TIMEOUT
#   define TIMEOUT 2  // 設置時延,默認爲2秒
#endif

#define OPT_DIRECT 1000   // 這個宏定義爲一個選項,該選項定義程序不創建子進程來運行測試用例,而是在主進程中直接運行
#define OPT_TESTDIR 1001  // 設置測試目錄,用來存放tmp文件以及日志文件

static struct option options[] =
{
#ifdef CMDLINE_OPTIONS
    CMDLINE_OPTIONS
#endif
    { "direct", no_argument, NULL, OPT_DIRECT },
    { "test-dir", required_argument, NULL, OPT_TESTDIR },
    { NULL, 0, NULL, 0 }
};

// 測試子進程的pid
static pid_t pid;   

// 存放tmp文件的目錄
static const char *test_dir;  

// tmp文件的列表,其中qelem的結構如下
// struct qelem
// {
//     struct qelem *q_forw;  指向前一個元素
//     struct qelem *q_back;  指向後一個元素
//     char q_data[1];        元素中保存的數據
// };
struct temp_name_list
{
    struct qelem q; // 用來指示元素在隊列中的保存位置
    char *name;     // tmp文件的名字
}*temp_name_list;

// 向tmp列表中添加tmp元素
static void
__attribute__ ((unused))  // gcc特性,指示該函數可能不使用,此時不要報錯
add_temp_file (const char *name)
{
    struct temp_name_list *newp
        = (struct temp_name_list *) calloc (sizeof (*newp), 1); // 爲newp分配一塊空間
    char *newname = strdup (name);
    if (newp != NULL && newname != NULL)
    {
        newp->name = newname;
        if (temp_name_list == NULL)   // 向隊列添加元素
	          temp_name_list = (struct temp_name_list *) &newp->q;
        else
	          insque (newp, temp_name_list);
    }
    else
        free (newp);  // 初始化失敗,釋放內存
}

// 刪除所有tmp文件,一般在進程結束後調用
static void
delete_temp_files (void)
{
    while (temp_name_list != NULL)
    {
        remove (temp_name_list->name);  //刪除文件
        free (temp_name_list->name);    //釋放內存

        struct temp_name_list *next
	          = (struct temp_name_list *) temp_name_list->q.q_forw;
        free (temp_name_list);
        temp_name_list = next;
    }
}

// 創建一個tmp文件.成功返回打開文件的描述符,失敗返回-1
// 如果filename不爲null,那麼在filename中保存文件名.在這種情況下,調用者應當釋放filename變量的內存
static int
__attribute__ ((unused))  // 這個函數是在測試用例中進行調用的,所以可能不使用
create_temp_file (const char *base, char **filename)
{
    char *fname;
    int fd;

    fname = (char *) malloc (strlen (test_dir) + 1 + strlen (base)  // 申請一個對應長度的內存塊
			  + sizeof ("XXXXXX"));
    if (fname == NULL)
    {
        puts ("out of memory"); 
        return -1;
    }
    strcpy (stpcpy (stpcpy (stpcpy (fname, test_dir), "/"), base), "XXXXXX"); // 組合字符串

    fd = mkstemp (fname);
    if (fd == -1)
    {
        printf ("cannot open temporary file '%s': %m\n", fname);
        free (fname);
        return -1;
    }

    add_temp_file (fname);
    if (filename != NULL)
        *filename = fname;
    else
        free (fname);

    return fd;
}

// 超時處理,超過時延則殺死子進程並以error退出
static void
__attribute__ ((noreturn))
signal_handler (int sig __attribute__ ((unused)))
{
    int killed;
    int status;

    assert (pid > 1); // 如果pid小於等於1,直接退出
    // 殺死所有子進程
    kill (-pid, SIGKILL);
    // 再殺一次
    kill (pid, SIGKILL);

    // 等 待 它 退 出 (指)
    int i;
    for (i = 0; i < 5; ++i)
    {
        killed = waitpid (pid, &status, WNOHANG|WUNTRACED); // 如果子進程未結束則返回0,結束則返回子進程的pid
        if (killed != 0)  
	          break;  // 如果子進程已經退出了,那麼退出循環

        // 設置時延給系統殺死子進程的時間,如果nanosleep中途退出,則說明子進程已經死亡,不需要再重啓一次
        struct timespec ts;
        ts.tv_sec = 0;
        ts.tv_nsec = 100000000;
        nanosleep (&ts, NULL);
    }
    if (killed != 0 && killed != pid)
    {
        printf ("Failed to kill test process: %m\n");
        exit (1);
    }

#ifdef CLEANUP_HANDLER
    CLEANUP_HANDLER;
#endif

    if (sig == SIGINT)
    {
        signal (sig, SIG_DFL);
        raise (sig);  // 發出sigint信號
    }

// 當定義了EXPECTED_SIGNAL宏,將超時不視爲測試出錯
#ifdef EXPECTED_SIGNAL
    if (EXPECTED_SIGNAL == SIGALRM)
        exit (0);
#endif

    if (killed == 0 || (WIFSIGNALED (status) && WTERMSIG (status) == SIGKILL))
        puts ("Timed out: killed the child process");
    else if (WIFSTOPPED (status))
        printf ("Timed out: the child process was %s\n",
	          strsignal (WSTOPSIG (status)));
    else if (WIFSIGNALED (status))
        printf ("Timed out: the child process got signal %s\n",
	          strsignal (WTERMSIG (status)));
    else
        printf ("Timed out: killed the child process but it exited %d\n",
	          WEXITSTATUS (status));

    // 以錯誤退出
    exit (1);
}

/* Avoid all the buffer overflow messages on stderr.  */
static void
__attribute__ ((unused))
ignore_stderr (void)
{
    int fd = open (_PATH_DEVNULL, O_WRONLY);
    if (fd == -1)
        close (STDERR_FILENO);
    else
    {
        dup2 (fd, STDERR_FILENO);
        close (fd);
    }
    setenv ("LIBC_FATAL_STDERR_", "1", 1);
}

/* Set fortification error handler.  Used when tests want to verify that bad
   code is caught by the library.  */
static void
__attribute__ ((unused))
set_fortify_handler (void (*handler) (int sig))
{
    struct sigaction sa;

    sa.sa_handler = handler;
    sa.sa_flags = 0;
    sigemptyset (&sa.sa_mask);

    sigaction (SIGABRT, &sa, NULL);
    ignore_stderr ();
}

/* Show people how to run the program.  */
static void
usage (void)
{
    size_t i;

    printf ("Usage: %s [options]\n"
        "\n"
        "Environment Variables:\n"
        "  TIMEOUTFACTOR          An integer used to scale the timeout\n"
        "  TMPDIR                 Where to place temporary files\n"
        "\n",
	      program_invocation_short_name);
    printf ("Options:\n");
    for (i = 0; options[i].name; ++i)
    {
        int indent;

        indent = printf ("  --%s", options[i].name);
        if (options[i].has_arg == required_argument)
	          indent += printf (" <arg>");
        printf ("%*s", 25 - indent, "");
        switch (options[i].val)
        {
        case OPT_DIRECT:
            printf ("Run the test directly (instead of forking & monitoring)");
            break;
        case OPT_TESTDIR:
            printf ("Override the TMPDIR env var");
            break;
        }
        printf ("\n");
    }
}

/* We provide the entry point here.  */
int main (int argc, char *argv[])
{
    int direct = 0;	/* Directly call the test function?  */
    int status;
    int opt;
    unsigned int timeoutfactor = 1;
    pid_t termpid;

    /* Make uses of freed and uninitialized memory known.  */
    mallopt (M_PERTURB, 42);

#ifdef STDOUT_UNBUFFERED
    setbuf (stdout, NULL);
#endif

    while ((opt = getopt_long (argc, argv, "+", options, NULL)) != -1)
    {
        switch (opt)
        {
          case '?':
              usage ();
              exit (1);
          case OPT_DIRECT:
              direct = 1;
              break;
          case OPT_TESTDIR:
              test_dir = optarg;
              break;
      #ifdef CMDLINE_PROCESS
          CMDLINE_PROCESS
      #endif
        }
    }

    /* If set, read the test TIMEOUTFACTOR value from the environment.
      This value is used to scale the default test timeout values. */
    char *envstr_timeoutfactor = getenv ("TIMEOUTFACTOR");
    if (envstr_timeoutfactor != NULL)
    {
        char *envstr_conv = envstr_timeoutfactor;
        unsigned long int env_fact;

        env_fact = strtoul (envstr_timeoutfactor, &envstr_conv, 0);

        if (*envstr_conv == '\0' && envstr_conv != envstr_timeoutfactor)
	        timeoutfactor = MAX (env_fact, 1);
    }

    /* Set TMPDIR to specified test directory.  */
    if (test_dir != NULL)
    {
        setenv ("TMPDIR", test_dir, 1);

        if (chdir (test_dir) < 0)
	    {
	        printf ("chdir: %m\n");
	        exit (1);
	    }
    }
    else
    {
        test_dir = getenv ("TMPDIR");
        if (test_dir == NULL || test_dir[0] == '\0')
	          test_dir = "/tmp";
    }

    /* Make sure we see all message, even those on stdout.  */
    setvbuf (stdout, NULL, _IONBF, 0);

    /* Make sure temporary files are deleted.  */
    atexit (delete_temp_files);

    /* Correct for the possible parameters.  */
    argv[optind - 1] = argv[0];
    argv += optind - 1;
    argc -= optind - 1;

    /* Call the initializing function, if one is available.  */
    // 如果存在初始函數,那麼調用它
#ifdef PREPARE
    PREPARE (argc, argv);
#endif

    const char *envstr_direct = getenv ("TEST_DIRECT");
    if (envstr_direct != NULL)
    {
        FILE *f = fopen (envstr_direct, "w");
        if (f == NULL)
        {
            printf ("cannot open TEST_DIRECT output file '%s': %m\n",
                envstr_direct);
            exit (1);
        }

        fprintf (f, "timeout=%u\ntimeoutfactor=%u\n", TIMEOUT, timeoutfactor);

    #ifdef EXPECTED_STATUS
        fprintf (f, "exit=%u\n", EXPECTED_STATUS);
    #endif
    #ifdef EXPECTED_SIGNAL
        switch (EXPECTED_SIGNAL)
        {
            default: abort ();
            # define init_sig(signo, name, text) \
            case signo: fprintf (f, "signal=%s\n", name); break;
            # include <siglist.h>
            # undef init_sig
            }
    #endif

        if (temp_name_list != NULL)
        {
            struct temp_name_list *n;
            fprintf (f, "temp_files=(\n");
            for (n = temp_name_list;
                n != NULL;
                n = (struct temp_name_list *) n->q.q_forw)
            {
                fprintf (f, "  '%s'\n", n->name);
            }
            fprintf (f, ")\n");
        }

        fclose (f);
        direct = 1;
    }

    // 如果我們不希望fork一個子進程,則直接運行函數
    if (direct)
        return TEST_FUNCTION;

    // 設置測試環境:
    // 1 防止核心轉儲
    // 2 設置計時器
    // 3 fork並執行函數

    pid = fork ();
    if (pid == 0)
    {
        // 以下爲子進程的代碼

    #ifdef RLIMIT_CORE
        /* Try to avoid dumping core.  */
        // 避免核心轉儲
        struct rlimit core_limit;
        core_limit.rlim_cur = 0;
        core_limit.rlim_max = 0;
        setrlimit (RLIMIT_CORE, &core_limit);
    #endif

    #ifdef RLIMIT_DATA
        // 如果測試內存泄露,防止它吃掉所有內存
        struct rlimit data_limit;
        if (getrlimit (RLIMIT_DATA, &data_limit) == 0)
        {
            if (TEST_DATA_LIMIT == RLIM_INFINITY)
                data_limit.rlim_cur = data_limit.rlim_max;
            else if (data_limit.rlim_cur > (rlim_t) TEST_DATA_LIMIT)
                data_limit.rlim_cur = MIN ((rlim_t) TEST_DATA_LIMIT,
                    data_limit.rlim_max);
            if (setrlimit (RLIMIT_DATA, &data_limit) < 0)
                printf ("setrlimit: RLIMIT_DATA: %m\n");
        }
        else
            printf ("getrlimit: RLIMIT_DATA: %m\n");
    #endif

        // 將測試進程放到它自己的進程組中,這樣當測試進程收到工作控制信號時不會影響整個構建
        if (setpgid (0, 0) != 0)
            printf ("Failed to set the process group ID: %m\n");

        // 執行測試函數,並將其返回值作爲脫出碼
        exit (TEST_FUNCTION);
    }
    else if (pid < 0)
    {
        printf ("Cannot fork test program: %m\n");
        exit (1);
    }

    // 以下爲主進程

    // 設置時延
    signal (SIGALRM, signal_handler);
    alarm (TIMEOUT * timeoutfactor);

    /* Make sure we clean up if the wrapper gets interrupted.  */
    signal (SIGINT, signal_handler);

    /* Wait for the regular termination.  */
    termpid = TEMP_FAILURE_RETRY (waitpid (pid, &status, 0));
    if (termpid == -1)
    {
        printf ("Waiting for test program failed: %m\n");
        exit (1);
    }
    if (termpid != pid)
    {
        printf ("Oops, wrong test program terminated: expected %ld, got %ld\n",
	          (long int) pid, (long int) termpid);
        exit (1);
    }

    // 進程正常終止
    if (WIFEXITED (status))
    {
    #ifndef EXPECTED_STATUS
        #ifndef EXPECTED_SIGNAL
              /* Simply exit with the return value of the test.  */
              return WEXITSTATUS (status);
        #else
              printf ("Expected signal '%s' from child, got none\n",
                  strsignal (EXPECTED_SIGNAL));
              exit (1);
        # endif
    #else
        if (WEXITSTATUS (status) != EXPECTED_STATUS)
        {
              printf ("Expected status %d, got %d\n",
                EXPECTED_STATUS, WEXITSTATUS (status));
              exit (1);
        }

        return 0;
    #endif
    }

    // 進程被計時器或其他信號殺死
    else
    {
    #ifndef EXPECTED_SIGNAL
        printf ("Didn't expect signal from child: got `%s'\n",
            strsignal (WTERMSIG (status)));
        exit (1);
    #else
        if (WTERMSIG (status) != EXPECTED_SIGNAL)
        {
            printf ("Incorrect signal from child: got `%s', need `%s'\n",
                strsignal (WTERMSIG (status)),
                strsignal (EXPECTED_SIGNAL));
            exit (1);
        }

        return 0;
    #endif
    }
}
