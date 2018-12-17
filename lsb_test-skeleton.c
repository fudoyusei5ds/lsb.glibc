#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

extern char **environ;

#include <std.h>
#include <tet_api.h>
#define NO_TESTS 1
int no_tests = NO_TESTS; 
static void test1(void);
public void (*setfunc)() = NULL;
public void (*clnfunc)() = NULL;
public struct tet_testlist tet_testlist[] = {
	  test1, 1,
	  NULL, 0
};

static void readout(void);

void test1(void)
{
    int testfailed=0;
    pid_t pid;
    pid = vfork();
    int status;
    if (pid == 0 )
    {
        // 以下爲子進程代碼

        // 將輸出流重定向到文件

        if(freopen("./out", "w", stdout) == NULL)
        {
            tet_printf("MainTest:redirect error: %m\n");
            exit(1);
        }

        // 复制字符串, 并执行测试用例
        // 这里可能会内存溢出?我觉得不太可能
        char tstdir[]="../../../src/";
        char *tstpath;
        tstpath=(char *)malloc(sizeof(char) * (strlen(FILENAME)+14));
        strcpy(tstpath,tstdir);
        char *pointer=tstpath+13;
        strcpy(pointer,FILENAME);

        if (execl(tstpath,FILENAME,NULL) == -1)
        { 
            tet_printf("MainTest:exec error: %m\n");
            exit(1);
        }
        free(tstpath);
    }
    else if (pid < 0 )
    {
        // 創建進程失敗的情況
        tet_printf("MainTest:fork error: %m\n");
        if(!testfailed++)
        {
            tet_result(TET_FAIL);
        }
        return;
    }

    // 主進程的代碼

    // 等待子進程退出
    pid_t termpid = waitpid(pid, &status, 0);
    // 判斷子進程失敗的狀態
    if (termpid == -1)
    {
        tet_printf("MainTest:wait process failed: %m");
        if(!testfailed++)
        {
            tet_result(TET_FAIL);
        }
        return;
    }
    if (termpid != pid)
    {
        tet_printf ("MainTest:Wrong test program terminated: expected %ld, got %ld\n",
	          (long int) pid, (long int) termpid);
        if(!testfailed++)
        {
            tet_result(TET_FAIL);
        }
        return;
    }

    // 分析子進程的返回值
    if (WIFEXITED(status))
    {
        // 如果子進程正常退出,分析子進程的退出碼
        if (!WEXITSTATUS(status))
        {
            if(!testfailed)
            {
                tet_result(TET_PASS);
                return;
            }
        }
        else
        {
            // 我們只假設子進程在通過exit退出的情況下,測試用例才是正常執行的
            // 所以如果子進程的退出碼爲0,說明測試用例在可以允許的範圍內出錯
            // 那麼,讀取out文件中的內容,再輸出到lsb中
            readout();
        }
    }
    else
    {
        // 子進程不是正常退出的
        tet_infoline("MainTest:child procss exit error");
    }
    tet_result(TET_FAIL);
    return;
}

static void readout()
{
    FILE *out = NULL;
    out = fopen("./out","r");
    if(out == NULL)
    {
        tet_printf("MainTest:open out error:%m");
        return;
    }
    char *test_info;
    test_info = (char *)malloc(sizeof(char *)*128);
    while(fgets(test_info, 128, out))
    {
        tet_infoline(test_info);
    }
    fclose(out);
    free(test_info);
    test_info = NULL;
}