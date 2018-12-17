## 将glibc elf库的测试用例移植到lsb中
首先, 目录文件结构如下:  
>src/  用来保存源码, 以及生成的动态链接库, 测试用例  
>tst/  用来保存生成的测试转接口  
>makefile  这个是从源码生成动态链接库以及测试用例所需的makefile, 需要在之后复制到src目录下  
>mk_mf.py  用来生成 生成测试转接口的makefile 的脚本, 由src目录下的makefile调用, 不要自己运行  
>mk_tst.py 用来从源makefile中提取相关语句, 具体内容看注释  
>mv_so_src.py 用来移动动态链接库的源码   
>mv_tst_src.py 用来移动测试用例的源码  
>readme.md  本文件  
>test-skeleton.c  测试用例框架, 不要改动  
>lsb_test-skeleton.c  测试用例框架, 不要改动  


### 1. 统计elf库的测试用例
有两个方法:  
1. 打开 elf/Makefile 文件, 其中test变量中储存的就是测试用例
2. 通过统计glibc测试之后的测试结果文件, 获取测试用例

### 2. 文件目录
因为elf库的测试用例之间存在复杂的相互依赖关系, 所以需要把elf库的所有测试用例的源码复制到src/, 而用于glibc的转接口则放在其余目录下(tst/)

### 3. 复制源码
运行mv_so_src.py和mv_tst_src.py将测试用例的源代码复制到src/

### 4. 提取makefile语句
运行mk_tst.py来从glibc的makefile中提取跟测试用例相关的代码, 然后将生成的elf_tst.mk复制到src/

### 5. 生成makefile
对elf库而言, 有以下几种测试用例类型:  
1. tests 基础的测试用例类型
2. tests-static 静态测试用例
3. tests-pie pie测试用例(位置无关的可执行程序)
4. tests-special shell语句类测试用例

对于其他库, 可能有其他种类的测试用例. 对于不同种类的测试用例, 其链接时所使用的参数也不同.  
另外, 需要从源makefile中将测试用例和so库的列表复制到生成的elf_tst.mk中.  
然后将本目录下的makefile文件复制到src目录下, 切换到src/  
1. 运行 make so 生成动态链接库  
2. 运行 make tst 生成测试用例  
3. 运行 make mk 生成接口用例makefile  

可能有些测试用例会出错, 需要根据报错信息进行具体的修改. 最终生成所有测试用例.  
需要注意的是, 有些测试用例并不是c文件而是c++文件,对于这种情况需要之后一一进行移植.  
有些测试用例使用shell语句来执行, 对于这种测试用例, 需要具体分析.

### 6.生成测试接口
现在, 在tst目录下已经生成了对应的接口的makefile, cd到想要运行的测试用例目录下, 运行make命令, 就能生成接口.  
然后运行接口.  
大功告成.  