# 这个脚本用来从本来的makefile中提取出so

import os, re

def mk_mf_src(libname):
    with open("so_ls_elf","r") as so_ls:
        