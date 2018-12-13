# 指定动态链接库
objpfx = ./
libdl = -ldl
libm = -lm
libdl = -ldl

####################

# CFLAGS 需要的参数:
# 1. std=gnu11 -fgnu89-inline 指定代码执行标准
# 2. $(CFLAGS-$(suffix $@)) 对不同测试用例, 指定不同的CFLAGS
# 3. CFLAGS-.os -fPIC
# 4. sysdep-CFLAGS 针对不同体系结构设置的参数, x86下为空
CFLAGS-.o =
CFLAGS-.os = -fPIC
override CFLAGS = -std=gnu11 -fgnu89-inline $(CFLAGS-$(suffix $@)) \
		$(CFLAGS-$(@F)) $(CFLAGS-$(<F)) $(sysdep-CFLAGS)
# CPPFLAGS 主要针对C++类型的测试用例, 这里先不考虑

# 编译生成目标文件的语句
compile-mkdep-flags = -MD -MP -MF $@.dt -MT $@
OUTPUT_OPTION = -o $@
compile.c = gcc $< -D_GNU_SOURCE -c $(CFLAGS) $(CPPFLAGS) # 这里需要指定宏定义
compile-command.c = $(compile.c) $(OUTPUT_OPTION) $(compile-mkdep-flags)

####################

hashstyle-LDFLAGS = -Wl,--hash-style=both
LDFLAGS.so += $(hashstyle-LDFLAGS)
combreloc-LDFLAGS = -Wl,-z,combreloc
LDFLAGS.so += $(combreloc-LDFLAGS)
relro-LDFLAGS = -Wl,-z,relro
LDFLAGS.so += $(relro-LDFLAGS)

# 使用默认的链接器
# 在生成测试用例so时, 不需要指定version-script, 所以这里先设为空
map-file = $(firstword $($(@F:.so=-map)) \
		       $(addprefix $(common-objpfx), \
				   $(filter $(@F:.so=.map),$(version-maps))))
load-map-file = # $(map-file:%=-Wl,--version-script=%)
sysdep-LDFLAGS = # 与体系结构相关
rtld-LDFLAGS =	# 用于指定动态链接器
# rpath-link 用于设置链接库时所需依赖库的路径, 因为在生成测试用例用so时, 不需要其他的路径, 因此设置为当前目录
rpath-link = ./
define build-module-helper
$(LINK.o) -shared -static-libgcc $(sysdep-LDFLAGS) $(rtld-LDFLAGS) \
	  $(if $($(@F)-no-z-defs)$(no-z-defs),,-Wl,-z,defs) \
	  $(load-map-file) \
	  $(LDFLAGS.so) $(LDFLAGS-$(@F:%.so=%).so) \
	  -L$(rpath-link) -Wl,-rpath-link=$(rpath-link)
endef

shlib-lds-flags =
# link-libc-args = ?
no-whole-archive = -Wl,--no-whole-archive
whole-archive = -Wl,--whole-archive
as-needed := -Wl,--as-needed
no-as-needed := -Wl,--no-as-needed
# 检查依赖文件中是否包含_pic.a结尾的文件, 如果有, 则在该位置前后加上whole-archive与no-whole-archive
# 这个变量和测试用例的生成没什么关系, 因此先注释掉, 只保留依赖选项的文件

build-module-helper-objlist = $^#\
	$(patsubst %_pic.a,$(whole-archive) %_pic.a $(no-whole-archive),\
		   $(filter-out %.lds $(map-file) $(+preinit) $(+postinit) \
				$(link-libc-deps),$^))
build-module-objlist = $(build-module-helper-objlist) $(LDLIBS-$(@F:%.so=%).so)
define build-module
$(build-module-helper) -o $@ $(shlib-lds-flags) \
		$(build-module-objlist)
endef

shlib-lds = 

####################

# 包含生成so的makefile
# include ./elf_so.mk
# 包含生成测试用例的makefile
include ./elf_tst.mk

####################

# 删除已生成的文件
clean: 
	rm *so
	rm *os
	rm *dt

# 生成动态链接库
so:	$(patsubst %,$(objpfx)%.so,$(modules-extra-names) $(modules-names))

# 编译源码
$(modules-names:%=$(objpfx)%.os): $(objpfx)%.os: \
		$(objpfx)%.c
	$(compile-command.c)

# 链接生成so
ifdef modules-names
$(modules-names:%=$(objpfx)%.so): $(objpfx)%.so: \
		$(objpfx)%.os $(shlib-lds) $(link-libs-deps)
	$(build-module)
endif

# 生成测试用例
tst:	$(tests)

# 编译源码
$(tests:%=$(objpfx)%.os): $(objpfx)%.os: \
		$(objpfx)%.c
	$(compile-command.c)
# 链接目标文件
$(tests:%=$(objpfx)%): $(objpfx)%: \
		$(objpfx)%.os
	gcc 