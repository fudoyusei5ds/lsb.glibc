include ./elf_makefile

compile-mkdep-flags = -MD -MP -MF $@.dt -MT $@
OUTPUT_OPTION = -o $@
compile-command.c = $(compile.c) $(OUTPUT_OPTION) $(compile-mkdep-flags)
compile.c = gcc $< -D_GNU_SOURCE -c $(CFLAGS) $(CPPFLAGS) 

hashstyle-LDFLAGS = -Wl,--hash-style=both
LDFLAGS.so += $(hashstyle-LDFLAGS)
combreloc-LDFLAGS = -Wl,-z,combreloc
LDFLAGS.so += $(combreloc-LDFLAGS)
relro-LDFLAGS = -Wl,-z,relro
LDFLAGS.so += $(relro-LDFLAGS)

# 如果默认的链接器足够好,那么可以使用默认的链接器
shlib-lds =
shlib-lds-flags =
link-libs-deps =

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
####################################################

so:	$(modules-names:%=$(objpfx)%.so)	


define build-module-helper
gcc -shared -static-libgcc $(sysdep-LDFLAGS) $(rtld-LDFLAGS) \
	  $(if $($(@F)-no-z-defs)$(no-z-defs),,-Wl,-z,defs) \
	  -B$(csu-objpfx) $(load-map-file) \
	  $(LDFLAGS.so) $(LDFLAGS-$(@F:%.so=%).so) \
	  -L$(subst :, -L,$(rpath-link)) -Wl,-rpath-link=$(rpath-link)
endef

define build-module
$(build-module-helper) -o $@ $(shlib-lds-flags) \
	  $(build-module-objlist) $(link-libc-args)
$(call after-link,$@)
endef

# link-libs-deps应该就是so默认的依赖项. 那么这里就可以完全复制本来的生成语句了,用之前的语句进行生成
ifdef modules-names
$(modules-names:%=$(objpfx)%.so): $(objpfx)%.so: \
		$(objpfx)%.os $(shlib-lds) $(link-libs-deps)
	$(build-module)
endif


$(modules-names:%=$(objpfx)%.os): $(objpfx)%.os: \
		$(objpfx)%.c
	$(compile-command.c) -fPIC

clean: 
	rm *so
	rm *os
	rm *dt