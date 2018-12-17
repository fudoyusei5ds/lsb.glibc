# 这个脚本用来为每个测试用例生成makefile文件
# 这个脚本是用src目录下的makefile运行的, 所以工作目录为src/

import sys,os

def mk_mf(filename,envs,args):
    # 第一个参数是文件名, 首先创建一个目录用来放测试用例
    try:
        os.mkdir("../tst/"+filename)
    except FileExistsError as e:
        None

    # 这里对环境变量和运行参数进行处理
    # 施工中...
    
    # 然后创建makefile
    with open("../tst/"+filename+"/makefile","w") as makefile:
        source="\
CC      = cc                    \n\
LIBDIR	= $(TET_ROOT)/lib/tet3\n\
INCDIR	= $(TET_ROOT)/inc/tet3\n\
VSXDIR  = $(TET_ROOT)/test_sets/SRC/INC\n\
VSXLIB  = $(TET_ROOT)/test_sets/SRC/LIB\n\
DEFINES = -D_GNU_SOURCE         \n\
ARGS    = -DFILENAME=\\\"{0}\\\"          \n\
\n\
CFLAGS	= -I$(INCDIR) -I$(VSXDIR) $(DEFINES) $(ARGS)   \n\
LIBS = $(VSXLIB)/genlib.a $(VSXLIB)/vlib.a $(LIBDIR)/libapi.a   \n\
SYSLIBS =   \n\
\n\
################################################### \n\
\n\
all:	{0} \n\
\t@chmod a+x  {0} \n\
\n\
{0}:	../../lsb_test-skeleton.c   \n\
\t@$(CC) $(CFLAGS) -o $@  $< $(LIBDIR)/tcm.o $(VSXLIB)/startup.o $(LIBS)    \n\
".format(filename)
        makefile.write(source)



if __name__=="__main__":
    mk_mf(sys.argv[1],sys.argv[2],sys.argv[3])