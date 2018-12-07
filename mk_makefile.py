# 这个脚本用来从本来的makefile中提取出so

import os, re

def mk_mf_src():
    # 直接读进内存, 反正没有多大
    # 我想到了一个更好的方法, 但是没时间写了
    elf_src=""
    with open("elf_mk_src", "r") as elf_mk_src:
        elf_src=elf_mk_src.read()
    # 首先将所有行合并为一行
    elf_src=re.sub(r"\\\n","",elf_src)
    so_ls=[]
    with open("so_ls_elf", "r") as so_ls_elf:
        so_ls=so_ls_elf.read().split("\n")

    with open("elf_makefile","w") as result:
        for sosrc_file in so_ls:
            if os.path.isfile(os.path.join("./src",sosrc_file[1:]+".c")):
                # 有这个文件, 再提取
                sosrc_file=sosrc_file[1:]
                # 首先处理依赖项 $(objpfx)testobj6.so: $(objpfx)testobj1.so $(objpfx)testobj2.so $(libdl)
                so_re=re.compile("\$\(objpfx\)"+sosrc_file+"\.so:.*\n")
                for re_result in so_re.finditer(elf_src):
                    result.write(re_result.group(0)+"\n")
                
                # 然后处理 LDFLAGS-tst-initorder2a.so = $(no-as-needed)
                so_re=re.compile(r"LDFLAGS\-"+sosrc_file+r"\.so.*\n")
                for re_result in so_re.finditer(elf_src):
                    result.write(re_result.group(0)+"\n")
                
                # 最后处理 testobj1.so-no-z-defs = yes
                so_re=re.compile(sosrc_file+r"\.so\-no\-z\-defs.*\n")
                for re_result in so_re.finditer(elf_src):
                    result.write(re_result.group(0)+"\n")


if __name__=="__main__":
    mk_mf_src()