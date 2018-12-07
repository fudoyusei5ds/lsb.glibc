### 将glibc elf库的测试用例移植到lsb中

#### 1. 统计elf库的测试用例
有两个方法:  
1. 打开 elf/Makefile 文件, 其中test变量中储存的就是测试用例
2. 通过统计glibc测试之后的测试结果文件, 获取测试用例

#### 2. 文件目录
因为elf库的测试用例之间存在复杂的相互依赖关系, 所以需要把elf库的所有测试用例的源码复制到一个目录下, 而用于glibc的转接口则放在其余目录下

#### 3. 生成测试用so
首先运行mv_so_src.py脚本来移动so库源码.  
so的生成主要有以下几点:  
1. 依赖: 有些so库的生成依赖于其他so.  
2. 编译选项: so库在生成时会选择不同的编译选项.  

需要Makefile中提取出对应的语句, 放入自己的Makefile中:   
1. 如 $(objpfx)tst-initorder2a.so: $(objpfx)tst-initorder2b.so 类型的依赖  
2. 如 LDFLAGS-tst-initorder2a.so = $(no-as-needed) 类型的参数设置
3. 如 testobj1.so-no-z-defs = yes 设置符号  

提取之后改名为elf_makefile, 同时加上一些其他命令


