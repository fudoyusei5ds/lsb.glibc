# 这个文件用来移动动态链接库的源码
# 结果不一定准确

import os,shutil

def mv_so_src(libname):
    with open("so_ls_"+libname,"r") as lib_list:
        lib_file=lib_list.readline()
        while lib_file:
            if "\n" in lib_file:
                if lib_file[0]=="0":
                    lib_file=lib_file[1:-1]+".c"
                else:
                    # 暂时忽略掉.cc结尾的文件
                    print(1)
                    lib_file=lib_list.readline()
                    continue
                    # lib_file=lib_file[1:-1]+".cc"
                    
                try:
                    shutil.copy("/home/tet/test_sets/workspace/glibc-2.23/{}/{}".format(libname,lib_file),"./src/")
                except:
                    print(lib_file)
                finally:    
                    lib_file=lib_list.readline()

if __name__=="__main__":
    mv_so_src("elf")
