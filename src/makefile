# 包含生成so的makefile
include ./elf_so.mk
# 包含生成测试用例的makefile
include ./elf_tst.mk

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

$(modules-names:%=$(objpfx)%.os): $(objpfx)%.os: \
		$(objpfx)%.c
	$(compile-command.c)

####################

# 链接生成动态链接库的语句
hashstyle-LDFLAGS = -Wl,--hash-style=both
LDFLAGS.so += $(hashstyle-LDFLAGS)
combreloc-LDFLAGS = -Wl,-z,combreloc
LDFLAGS.so += $(combreloc-LDFLAGS)
relro-LDFLAGS = -Wl,-z,relro
LDFLAGS.so += $(relro-LDFLAGS)

# 使用默认的链接器
shlib-lds =
shlib-lds-flags =

build-module-helper-objlist = \
	$(patsubst %_pic.a,$(whole-archive) %_pic.a $(no-whole-archive),\
		   $(filter-out %.lds $(map-file) $(+preinit) $(+postinit) \
				$(link-libc-deps),$^))
build-module-objlist = $(build-module-helper-objlist) $(LDLIBS-$(@F:%.so=%).so)

map-file = $(firstword $($(@F:.so=-map)) \
		       $(addprefix $(common-objpfx), \
				   $(filter $(@F:.so=.map),$(version-maps))))
load-map-file = $(map-file:%=-Wl,--version-script=%)

csu-objpfx =

# rtld-installed-name = ld.so.1
# prefix = /usr/local
# exec_prefix = $(prefix)
# slibdir = $(exec_prefix)/lib
# rtlddir = $(slibdir)
rtld-LDFLAGS =	

define build-module-helper
gcc -shared -static-libgcc $(sysdep-LDFLAGS) $(rtld-LDFLAGS) \
	  $(if $($(@F)-no-z-defs)$(no-z-defs),,-Wl,-z,defs) \
	  -B$(csu-objpfx) $(load-map-file) \
	  $(LDFLAGS.so) $(LDFLAGS-$(@F:%.so=%).so) \
	  -L$(subst :, -L,$(rpath-link)) -Wl,-rpath-link=$(rpath-link)
endef

define build-module
$(build-module-helper) -o $@ $(shlib-lds-flags) \
	  $(csu-objpfx)abi-note.o $(build-module-objlist) $(link-libc-args)
$(call after-link,$@)
endef

# 链接生成so的语句
ifdef modules-names
$(modules-names:%=$(objpfx)%.so): $(objpfx)%.so: \
		$(objpfx)%.os $(shlib-lds) $(link-libs-deps)
	$(build-module)
endif

####################

clean: 
	rm *so
	rm *os
	rm *dt

so:	$(modules-names:%=$(objpfx)%.so)\
	$(patsubst %,$(objpfx)%.so,$(tlsmod17a-modules))\
	$(patsubst %,$(objpfx)%.so,$(tlsmod18a-modules))
	# $(objpfx)tst-initorder2a.so
	# $(objpfx)tst-initorder2b.so
	# $(objpfx)tst-initorder2c.so
	# $(objpfx)tst-initorder2d.so