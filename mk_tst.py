# 这个文件用来从源代码的makefile中提取出测试用例相关的语句
# 主要分为以下几种
# 1. $(objpfx)tst-tls10: $(objpfx)tst-tlsmod8.so $(objpfx)tst-tlsmod7.so
# 2. $(objpfx)tst-tls14.out: $(objpfx)tst-tlsmod14b.so
# 3. CPPFLAGS-tst-execstack.c = -DUSE_PTHREADS=0
# 4. LDFLAGS-tst-execstack = -Wl,-z,noexecstack
# 5. -no-z-defs
# 6. -ARGS
# 7. -ENV

import re

def mk_tst(makefile):
    # 声明正则表达式, 以对应不同的情况
    # 这3种情况是测试用例和so库共有的语句
    re1=re.compile(r"(\$\(objpfx\))([\w\-]+)((:)|(\.out:)|(\.so))")
    re2=re.compile(r"(CPPFLAGS-)([\w\-]+)")
    re3=re.compile(r"(LDFLAGS-)([\w\-]+)")
    # 以下为so库独有的语句
    re4=re.compile(r"[\w\-\.]+-no-z-defs")
    # 以下为测试用例独有的语句
    # 1. 提取测试用例执行时的环境变量
    # 2. 提取测试用例执行时的参数
    re5=re.compile(r"[\w\-]+\-ARGS")
    re6=re.compile(r"[\w\-]+\-ENV")

    # 以上语句不一定包括所有的, 如果有发现漏掉的可以再添加
    # 如果有多选的语句, 并不影响, 因为最终编译时只找需要的语句

    # 首先打开makefile源文件
    with open("elf_tst.mk","w") as result:
        with open(makefile,"r") as makefile:
            line=makefile.readline()
            while line:
                # python读取行会无视"\", 所以会把一整行读成两段
                # 这里将一行多次读取并进行合并
                # 有一个更好的方法, 但是太麻烦
                
                while line.strip() and line[-2]=="\\":
                    line=line[:-2]+makefile.readline()
                
                # 检查这一行是否需要提取
                if re1.match(line) or re2.match(line) or re3.match(line) or re4.match(line) or re5.match(line) or re6.match(line):
                    result.write(line)

                line=makefile.readline()

if __name__=="__main__":
    mk_tst("elf_mk_src.mk")