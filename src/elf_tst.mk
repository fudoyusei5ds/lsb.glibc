tests = 






$(objpfx)sotruss-lib.so: $(objpfx)sotruss-lib.os
$(objpfx)sotruss-lib.so: $(common-objpfx)libc.so $(objpfx)ld.so 	$(common-objpfx)libc_nonshared.a
$(objpfx)sotruss: sotruss.sh $(common-objpfx)config.make
tst-tls9-static-ENV =        LD_LIBRARY_PATH=$(objpfx):$(common-objpfx):$(common-objpfx)dlfcn
LDFLAGS-tst-dlopen-aout = $(no-pie-ldflag)
$(objpfx)tst-protected1a: $(addprefix $(objpfx),tst-protected1moda.so tst-protected1modb.so)
$(objpfx)tst-protected1b: $(addprefix $(objpfx),tst-protected1modb.so tst-protected1moda.so)
tst-protected1modb.so-no-z-defs = yes
$(objpfx)sotruss-lib.so: $(shlib-lds)
$(objpfx)ld.so: $(objpfx)librtld.os $(ld-map)
CPPFLAGS-dl-load.c = -I$(objpfx). -I$(csu-objpfx).
$(objpfx)ldd: ldd.bash.in $(common-objpfx)soversions.mk 	      $(common-objpfx)config.make
$(objpfx)sprof: $(libdl)
$(objpfx)sln: $(sln-modules:%=$(objpfx)%.o)
$(objpfx)ldconfig: $(ldconfig-modules:%=$(objpfx)%.o)
$(objpfx)testobj1.so: $(libdl)
$(objpfx)testobj1_1.so: $(objpfx)testobj1.so $(libdl)
$(objpfx)testobj2.so: $(objpfx)testobj1.so $(libdl)
$(objpfx)testobj3.so: $(libdl)
$(objpfx)testobj4.so: $(libdl)
$(objpfx)testobj5.so: $(libdl)
$(objpfx)testobj6.so: $(objpfx)testobj1.so $(objpfx)testobj2.so $(libdl)
$(objpfx)failobj.so: $(objpfx)testobj6.so
$(objpfx)dep1.so: $(objpfx)dep2.so $(objpfx)dep4.so
$(objpfx)dep2.so: $(objpfx)dep3.so $(objpfx)dep4.so
$(objpfx)dep4.so: $(objpfx)dep3.so
$(objpfx)nodelmod3.so: $(objpfx)nodelmod4.so
$(objpfx)nextmod1.so: $(libdl)
$(objpfx)neededobj1.so: $(libdl)
$(objpfx)neededobj2.so: $(objpfx)neededobj1.so $(libdl)
$(objpfx)neededobj3.so: $(objpfx)neededobj1.so $(objpfx)neededobj2.so $(libdl)
$(objpfx)neededobj4.so: $(objpfx)neededobj1.so $(objpfx)neededobj2.so 			$(objpfx)neededobj3.so $(libdl)
$(objpfx)neededobj6.so: $(objpfx)neededobj5.so
$(objpfx)unload2mod.so: $(objpfx)unload2dep.so
$(objpfx)ltglobmod2.so: $(libdl)
$(objpfx)firstobj.so: $(shared-thread-library)
$(objpfx)globalmod1.so: $(libdl)
$(objpfx)reldep4mod1.so: $(objpfx)reldep4mod3.so
$(objpfx)reldep4mod2.so: $(objpfx)reldep4mod4.so
$(objpfx)dblloadmod1.so: $(objpfx)dblloadmod3.so
$(objpfx)dblloadmod2.so: $(objpfx)dblloadmod3.so
$(objpfx)reldepmod5.so: $(objpfx)reldepmod2.so
$(objpfx)reldepmod6.so: $(objpfx)reldepmod2.so
$(objpfx)reldep6mod1.so: $(objpfx)reldep6mod0.so
$(objpfx)reldep6mod2.so: $(objpfx)reldep6mod1.so
$(objpfx)reldep6mod3.so: $(objpfx)reldep6mod2.so
$(objpfx)reldep6mod4.so: $(objpfx)reldep6mod1.so
$(objpfx)tst-tlsmod3.so: $(objpfx)tst-tlsmod2.so
$(objpfx)tst-tlsmod8.so: $(objpfx)tst-tlsmod7.so
$(objpfx)tst-tlsmod10.so: $(objpfx)tst-tlsmod9.so
$(objpfx)tst-tlsmod12.so: $(objpfx)tst-tlsmod11.so
$(objpfx)tst-tlsmod13a.so: $(objpfx)tst-tlsmod13.so
$(objpfx)tst-tlsmod5.so: $(common-objpfx)libc.so
$(objpfx)tst-tlsmod6.so: $(common-objpfx)libc.so
$(objpfx)tst-tls19mod1.so: $(objpfx)tst-tls19mod2.so $(objpfx)tst-tls19mod3.so
$(objpfx)tst-tls19mod3.so: $(objpfx)ld.so
$(objpfx)reldep8mod3.so: $(objpfx)reldep8mod1.so $(objpfx)reldep8mod2.so
$(objpfx)nodel2mod3.so: $(objpfx)nodel2mod1.so $(objpfx)nodel2mod2.so
$(objpfx)reldep9mod2.so: $(objpfx)reldep9mod1.so
$(objpfx)reldep9mod3.so: $(objpfx)reldep9mod1.so $(objpfx)reldep9mod2.so
$(objpfx)unload3mod1.so: $(objpfx)unload3mod3.so
$(objpfx)unload3mod2.so: $(objpfx)unload3mod3.so
$(objpfx)unload3mod3.so: $(objpfx)unload3mod4.so
$(objpfx)unload4mod1.so: $(objpfx)unload4mod2.so $(objpfx)unload4mod3.so
$(objpfx)unload4mod2.so: $(objpfx)unload4mod4.so $(objpfx)unload4mod3.so
$(objpfx)unload6mod1.so: $(libdl)
$(objpfx)unload6mod2.so: $(libdl)
$(objpfx)unload6mod3.so: $(libdl)
$(objpfx)unload7mod1.so: $(libdl)
$(objpfx)unload7mod2.so: $(objpfx)unload7mod1.so
$(objpfx)unload8mod1.so: $(objpfx)unload8mod2.so
$(objpfx)unload8mod2.so: $(objpfx)unload8mod3.so
$(objpfx)unload8mod3.so: $(libdl)
$(objpfx)tst-initordera2.so: $(objpfx)tst-initordera1.so
$(objpfx)tst-initorderb2.so: $(objpfx)tst-initorderb1.so $(objpfx)tst-initordera2.so
$(objpfx)tst-initordera3.so: $(objpfx)tst-initorderb2.so $(objpfx)tst-initorderb1.so
$(objpfx)tst-initordera4.so: $(objpfx)tst-initordera3.so
$(objpfx)tst-initorder: $(objpfx)tst-initordera4.so $(objpfx)tst-initordera1.so $(objpfx)tst-initorderb2.so
$(objpfx)tst-null-argv: $(objpfx)tst-null-argv-lib.so
$(objpfx)tst-tlsalign: $(objpfx)tst-tlsalign-lib.so
$(objpfx)tst-nodelete-opened.out: $(objpfx)tst-nodelete-opened-lib.so
$(objpfx)tst-nodelete-opened: $(libdl)
$(objpfx)tst-tlsalign-extern: $(objpfx)tst-tlsalign-vars.o
$(objpfx)tst-tlsalign-extern-static: $(objpfx)tst-tlsalign-vars.o
tst-null-argv-ENV = LD_DEBUG=all LD_DEBUG_OUTPUT=$(objpfx)tst-null-argv.debug.out
LDFLAGS-nodel2mod3.so = $(no-as-needed)
LDFLAGS-reldepmod5.so = $(no-as-needed)
LDFLAGS-reldep6mod1.so = $(no-as-needed)
LDFLAGS-reldep6mod4.so = $(no-as-needed)
LDFLAGS-reldep8mod3.so = $(no-as-needed)
LDFLAGS-unload4mod1.so = $(no-as-needed)
LDFLAGS-unload4mod2.so = $(no-as-needed)
LDFLAGS-tst-initorder = $(no-as-needed)
LDFLAGS-tst-initordera2.so = $(no-as-needed)
LDFLAGS-tst-initordera3.so = $(no-as-needed)
LDFLAGS-tst-initordera4.so = $(no-as-needed)
LDFLAGS-tst-initorderb2.so = $(no-as-needed)
LDFLAGS-tst-tlsmod5.so = -nostdlib $(no-as-needed)
LDFLAGS-tst-tlsmod6.so = -nostdlib $(no-as-needed)
testobj1.so-no-z-defs = yes
testobj3.so-no-z-defs = yes
testobj4.so-no-z-defs = yes
testobj5.so-no-z-defs = yes
testobj6.so-no-z-defs = yes
failobj.so-no-z-defs = yes
constload2.so-no-z-defs = yes
constload3.so-no-z-defs = yes
nodelmod1.so-no-z-defs = yes
nodelmod2.so-no-z-defs = yes
nodelmod4.so-no-z-defs = yes
nodel2mod2.so-no-z-defs = yes
reldepmod2.so-no-z-defs = yes
reldepmod3.so-no-z-defs = yes
reldepmod4.so-no-z-defs = yes
reldep4mod4.so-no-z-defs = yes
reldep4mod2.so-no-z-defs = yes
ltglobmod2.so-no-z-defs = yes
dblloadmod3.so-no-z-defs = yes
tst-tlsmod1.so-no-z-defs = yes
tst-tlsmod2.so-no-z-defs = yes
tst-tlsmod3.so-no-z-defs = yes
tst-tlsmod4.so-no-z-defs = yes
tst-tlsmod7.so-no-z-defs = yes
tst-tlsmod8.so-no-z-defs = yes
tst-tlsmod9.so-no-z-defs = yes
tst-tlsmod10.so-no-z-defs = yes
tst-tlsmod12.so-no-z-defs = yes
tst-tlsmod14a.so-no-z-defs = yes
tst-tlsmod14b.so-no-z-defs = yes
tst-tlsmod15a.so-no-z-defs = yes
tst-tlsmod16b.so-no-z-defs = yes
circlemod2.so-no-z-defs = yes
circlemod3.so-no-z-defs = yes
circlemod3a.so-no-z-defs = yes
reldep8mod2.so-no-z-defs = yes
reldep9mod1.so-no-z-defs = yes
unload3mod4.so-no-z-defs = yes
unload4mod1.so-no-z-defs = yes
ifuncmod1.so-no-z-defs = yes
ifuncmod5.so-no-z-defs = yes
ifuncmod6.so-no-z-defs = yes
tst-auditmod9a.so-no-z-defs = yes
tst-auditmod9b.so-no-z-defs = yes
tst-nodelete-uniquemod.so-no-z-defs = yes
tst-nodelete-rtldmod.so-no-z-defs = yes
tst-nodelete-zmod.so-no-z-defs = yes
tst-nodelete2mod.so-no-z-defs = yes
$(objpfx)loadtest: $(libdl)
LDFLAGS-loadtest = -rdynamic
$(objpfx)loadtest.out: $(test-modules)
$(objpfx)neededtest: $(libdl)
$(objpfx)neededtest.out: $(objpfx)neededobj1.so $(objpfx)neededobj2.so 			 $(objpfx)neededobj3.so
$(objpfx)neededtest2: $(libdl)
$(objpfx)neededtest2.out: $(objpfx)neededobj1.so $(objpfx)neededobj2.so 			  $(objpfx)neededobj3.so
$(objpfx)neededtest3: $(libdl)
$(objpfx)neededtest3.out: $(objpfx)neededobj1.so $(objpfx)neededobj2.so 			  $(objpfx)neededobj3.so $(objpfx)neededobj4.so
$(objpfx)neededtest4: $(libdl) $(objpfx)neededobj1.so
$(objpfx)neededtest4.out: $(objpfx)neededobj5.so $(objpfx)neededobj6.so
$(objpfx)restest1: $(objpfx)testobj1.so $(objpfx)testobj1_1.so $(libdl)
LDFLAGS-restest1 = -rdynamic
$(objpfx)restest2: $(libdl)
LDFLAGS-restest2 = -rdynamic
$(objpfx)restest1.out: $(test-modules)
$(objpfx)preloadtest: $(objpfx)testobj6.so
LDFLAGS-preloadtest = -rdynamic
$(objpfx)preloadtest.out: $(preloadtest-preloads:%=$(objpfx)%.so)
preloadtest-ENV =   LD_PRELOAD=$(subst $(empty) ,:,$(strip $(preloadtest-preloads:=.so)))
$(objpfx)loadfail: $(libdl)
LDFLAGS-loadfail = -rdynamic
$(objpfx)loadfail.out: $(objpfx)failobj.so
$(objpfx)multiload: $(libdl)
LDFLAGS-multiload = -rdynamic
$(objpfx)multiload.out: $(objpfx)testobj1.so
$(objpfx)origtest: $(libdl)
LDFLAGS-origtest = -rdynamic
$(objpfx)origtest.out: $(objpfx)testobj1.so
$(objpfx)resolvfail: $(libdl) $(shared-thread-library)
$(objpfx)resolvfail: $(libdl)
$(objpfx)constload1: $(libdl)
$(objpfx)constload1.out: $(objpfx)constload2.so $(objpfx)constload3.so
$(objpfx)circleload1: $(libdl)
$(objpfx)circleload1.out: $(objpfx)circlemod1.so 			  $(objpfx)circlemod1a.so
$(objpfx)circlemod1.so: $(objpfx)circlemod2.so
$(objpfx)circlemod2.so: $(objpfx)circlemod3.so
$(objpfx)circlemod1a.so: $(objpfx)circlemod2a.so
$(objpfx)circlemod2a.so: $(objpfx)circlemod3a.so
$(objpfx)order: $(addprefix $(objpfx),dep4.so dep3.so dep2.so dep1.so)
$(objpfx)order-cmp.out: $(objpfx)order.out
$(objpfx)vismain: $(addprefix $(objpfx),vismod1.so vismod2.so)
$(objpfx)vismain.out: $(addprefix $(objpfx),vismod3.so)
vismain-ENV = LD_PRELOAD=$(addprefix $(objpfx),vismod3.so)
$(objpfx)noload: $(objpfx)testobj1.so $(libdl)
LDFLAGS-noload = -rdynamic $(no-as-needed)
$(objpfx)noload.out: $(objpfx)testobj5.so
$(objpfx)noload-mem.out: $(objpfx)noload.out
noload-ENV = MALLOC_TRACE=$(objpfx)noload.mtrace
LDFLAGS-nodelete = -rdynamic
LDFLAGS-nodelmod1.so = -Wl,--enable-new-dtags,-z,nodelete
LDFLAGS-nodelmod4.so = -Wl,--enable-new-dtags,-z,nodelete
$(objpfx)nodelete: $(libdl)
$(objpfx)nodelete.out: $(objpfx)nodelmod1.so $(objpfx)nodelmod2.so 		       $(objpfx)nodelmod3.so
LDFLAGS-nodlopenmod.so = -Wl,--enable-new-dtags,-z,nodlopen
$(objpfx)nodlopen: $(libdl)
$(objpfx)nodlopen.out: $(objpfx)nodlopenmod.so
$(objpfx)nodlopenmod2.so: $(objpfx)nodlopenmod.so
$(objpfx)nodlopen2: $(libdl)
$(objpfx)nodlopen2.out: $(objpfx)nodlopenmod2.so
$(objpfx)filtmod1.so: $(objpfx)filtmod1.os $(objpfx)filtmod2.so
$(objpfx)filter: $(objpfx)filtmod1.so
$(objpfx)unload: $(libdl)
$(objpfx)unload.out: $(objpfx)unloadmod.so
$(objpfx)reldep: $(libdl)
$(objpfx)reldep.out: $(objpfx)reldepmod1.so $(objpfx)reldepmod2.so
$(objpfx)reldep2: $(libdl)
$(objpfx)reldep2.out: $(objpfx)reldepmod1.so $(objpfx)reldepmod3.so
$(objpfx)reldep3: $(libdl)
$(objpfx)reldep3.out: $(objpfx)reldepmod1.so $(objpfx)reldepmod4.so
$(objpfx)reldep4: $(libdl)
$(objpfx)reldep4.out: $(objpfx)reldep4mod1.so $(objpfx)reldep4mod2.so
$(objpfx)next: $(objpfx)nextmod1.so $(objpfx)nextmod2.so $(libdl)
LDFLAGS-next = $(no-as-needed)
$(objpfx)unload2: $(libdl)
$(objpfx)unload2.out: $(objpfx)unload2mod.so $(objpfx)unload2dep.so
$(objpfx)lateglobal: $(libdl)
$(objpfx)lateglobal.out: $(objpfx)ltglobmod1.so $(objpfx)ltglobmod2.so
$(objpfx)tst-pathopt: $(libdl)
$(objpfx)tst-pathopt.out: tst-pathopt.sh $(objpfx)tst-pathopt 			  $(objpfx)pathoptobj.so
$(objpfx)tst-rtld-load-self.out: tst-rtld-load-self.sh $(objpfx)ld.so
$(objpfx)initfirst: $(libdl)
$(objpfx)initfirst.out: $(objpfx)firstobj.so
$(objpfx)global: $(objpfx)globalmod1.so
$(objpfx)global.out: $(objpfx)reldepmod1.so
$(objpfx)dblload: $(libdl)
$(objpfx)dblload.out: $(objpfx)dblloadmod1.so $(objpfx)dblloadmod2.so
$(objpfx)dblunload: $(libdl)
$(objpfx)dblunload.out: $(objpfx)dblloadmod1.so $(objpfx)dblloadmod2.so
$(objpfx)reldep5: $(libdl)
$(objpfx)reldep5.out: $(objpfx)reldepmod5.so $(objpfx)reldepmod6.so
$(objpfx)reldep6: $(libdl)
$(objpfx)reldep6.out: $(objpfx)reldep6mod3.so $(objpfx)reldep6mod4.so
$(objpfx)reldep7: $(libdl)
$(objpfx)reldep7.out: $(objpfx)reldep7mod1.so $(objpfx)reldep7mod2.so
$(objpfx)reldep8: $(libdl)
$(objpfx)reldep8.out: $(objpfx)reldep8mod3.so
LDFLAGS-nodel2mod2.so = -Wl,--enable-new-dtags,-z,nodelete
$(objpfx)nodelete2: $(libdl)
$(objpfx)nodelete2.out: $(objpfx)nodel2mod3.so
$(objpfx)reldep9: $(libdl)
$(objpfx)reldep9.out: $(objpfx)reldep9mod3.so
$(objpfx)tst-tls3: $(objpfx)tst-tlsmod1.so
$(objpfx)tst-tls4: $(libdl)
$(objpfx)tst-tls4.out: $(objpfx)tst-tlsmod2.so
$(objpfx)tst-tls5: $(libdl)
$(objpfx)tst-tls5.out: $(objpfx)tst-tlsmod2.so
$(objpfx)tst-tls6: $(libdl)
$(objpfx)tst-tls6.out: $(objpfx)tst-tlsmod2.so
$(objpfx)tst-tls7: $(libdl)
$(objpfx)tst-tls7.out: $(objpfx)tst-tlsmod3.so
$(objpfx)tst-tls8: $(libdl)
$(objpfx)tst-tls8.out: $(objpfx)tst-tlsmod3.so $(objpfx)tst-tlsmod4.so
$(objpfx)tst-tls9: $(libdl)
$(objpfx)tst-tls9.out: $(objpfx)tst-tlsmod5.so $(objpfx)tst-tlsmod6.so
$(objpfx)tst-tls10: $(objpfx)tst-tlsmod8.so $(objpfx)tst-tlsmod7.so
$(objpfx)tst-tls11: $(objpfx)tst-tlsmod10.so $(objpfx)tst-tlsmod9.so
$(objpfx)tst-tls12: $(objpfx)tst-tlsmod12.so $(objpfx)tst-tlsmod11.so
$(objpfx)tst-tls13: $(libdl)
$(objpfx)tst-tls13.out: $(objpfx)tst-tlsmod13a.so
$(objpfx)tst-tls14: $(objpfx)tst-tlsmod14a.so $(libdl)
$(objpfx)tst-tls14.out: $(objpfx)tst-tlsmod14b.so
$(objpfx)tst-tls15: $(libdl)
$(objpfx)tst-tls15.out: $(objpfx)tst-tlsmod15a.so $(objpfx)tst-tlsmod15b.so
$(objpfx)tst-tls-dlinfo: $(libdl)
$(objpfx)tst-tls-dlinfo.out: $(objpfx)tst-tlsmod2.so
$(objpfx)tst-tls16: $(libdl)
$(objpfx)tst-tls16.out: $(objpfx)tst-tlsmod16a.so $(objpfx)tst-tlsmod16b.so
$(objpfx)tst-tls17: $(libdl)
$(objpfx)tst-tls17.out: $(objpfx)tst-tlsmod17b.so
$(objpfx)tst-tlsmod17b.so: $(patsubst %,$(objpfx)%.so,$(tlsmod17a-modules))
$(objpfx)tst-tls18: $(libdl)
$(objpfx)tst-tls18.out: $(patsubst %,$(objpfx)%.so,$(tlsmod18a-modules))
$(objpfx)tst-tls19: $(libdl)
$(objpfx)tst-tls19.out: $(objpfx)tst-tls19mod1.so
$(objpfx)tst-align: $(libdl)
$(objpfx)tst-align.out: $(objpfx)tst-alignmod.so
$(objpfx)tst-align2: $(objpfx)tst-alignmod2.so
$(objpfx)unload3: $(libdl)
$(objpfx)unload3.out: $(objpfx)unload3mod1.so $(objpfx)unload3mod2.so 		      $(objpfx)unload3mod3.so $(objpfx)unload3mod4.so
$(objpfx)unload4: $(libdl)
$(objpfx)unload4.out: $(objpfx)unload4mod1.so $(objpfx)unload4mod3.so
$(objpfx)unload5: $(libdl)
$(objpfx)unload5.out: $(objpfx)unload3mod1.so $(objpfx)unload3mod2.so 		      $(objpfx)unload3mod3.so $(objpfx)unload3mod4.so
$(objpfx)unload6: $(libdl)
$(objpfx)unload6.out: $(objpfx)unload6mod1.so $(objpfx)unload6mod2.so 		      $(objpfx)unload6mod3.so
$(objpfx)unload7: $(libdl)
$(objpfx)unload7.out: $(objpfx)unload7mod1.so $(objpfx)unload7mod2.so
unload7-ENV = MALLOC_PERTURB_=85
$(objpfx)unload8: $(libdl)
$(objpfx)unload8.out: $(objpfx)unload8mod1.so $(objpfx)unload8mod1x.so
$(objpfx)tst-tls9-static: $(common-objpfx)dlfcn/libdl.a
$(objpfx)tst-tls9-static.out: $(objpfx)tst-tlsmod5.so $(objpfx)tst-tlsmod6.so
$(objpfx)tst-execstack: $(libdl)
$(objpfx)tst-execstack.out: $(objpfx)tst-execstack-mod.so
CPPFLAGS-tst-execstack.c = -DUSE_PTHREADS=0
LDFLAGS-tst-execstack = -Wl,-z,noexecstack
LDFLAGS-tst-execstack-mod = -Wl,-z,execstack
$(objpfx)tst-execstack-needed: $(objpfx)tst-execstack-mod.so
LDFLAGS-tst-execstack-needed = -Wl,-z,noexecstack
LDFLAGS-tst-execstack-prog = -Wl,-z,execstack
LDFLAGS-tst-array2 = $(no-as-needed)
LDFLAGS-tst-array5 = $(no-as-needed)
$(objpfx)tst-array1-cmp.out: tst-array1.exp $(objpfx)tst-array1.out
$(objpfx)tst-array1-static-cmp.out: tst-array1.exp 				    $(objpfx)tst-array1-static.out
$(objpfx)tst-array2: $(objpfx)tst-array2dep.so
$(objpfx)tst-array2-cmp.out: tst-array2.exp $(objpfx)tst-array2.out
$(objpfx)tst-array3-cmp.out: tst-array1.exp $(objpfx)tst-array3.out
$(objpfx)tst-array4: $(libdl)
$(objpfx)tst-array4.out: $(objpfx)tst-array2dep.so
$(objpfx)tst-array4-cmp.out: tst-array4.exp $(objpfx)tst-array4.out
$(objpfx)tst-array5: $(objpfx)tst-array5dep.so
$(objpfx)tst-array5-cmp.out: tst-array5.exp $(objpfx)tst-array5.out
$(objpfx)tst-array5-static-cmp.out: tst-array5-static.exp 				$(objpfx)tst-array5-static.out
$(objpfx)tst-pie1: $(objpfx)tst-piemod1.so
$(objpfx)check-textrel.out: $(..)scripts/check-textrel.awk 			    $(all-built-dso:=.dyn)
$(objpfx)execstack-default: $(first-word $(wildcard $(sysdirs:%=%/stackinfo.h)))
$(objpfx)check-execstack.out: $(..)scripts/check-execstack.awk 			      $(objpfx)execstack-default 			      $(all-built-dso:=.phdr)
$(objpfx)tst-dlmodcount: $(libdl)
$(objpfx)tst-dlmodcount.out: $(test-modules)
$(objpfx)check-localplt.out: $(..)scripts/check-localplt.awk 			     $(..)scripts/localplt.awk 			     $(localplt-built-dso:=.jmprel) 			     localplt.data
$(objpfx)tst-dlopenrpathmod.so: $(libdl)
$(objpfx)tst-dlopenrpath: $(objpfx)tst-dlopenrpathmod.so $(libdl)
LDFLAGS-tst-dlopenrpathmod.so += -Wl,-rpath,\$$ORIGIN/test-subdir
$(objpfx)tst-dlopenrpath.out: $(objpfx)firstobj.so
$(objpfx)tst-deep1mod2.so: $(objpfx)tst-deep1mod3.so
$(objpfx)tst-deep1: $(libdl) $(objpfx)tst-deep1mod1.so
$(objpfx)tst-deep1.out: $(objpfx)tst-deep1mod2.so
LDFLAGS-tst-deep1 += -rdynamic
tst-deep1mod3.so-no-z-defs = yes
$(objpfx)tst-dlmopen1mod.so: $(libdl)
$(objpfx)tst-dlmopen1: $(libdl)
$(objpfx)tst-dlmopen1.out: $(objpfx)tst-dlmopen1mod.so
$(objpfx)tst-dlmopen2: $(libdl)
$(objpfx)tst-dlmopen2.out: $(objpfx)tst-dlmopen1mod.so
$(objpfx)tst-dlmopen3: $(libdl)
$(objpfx)tst-dlmopen3.out: $(objpfx)tst-dlmopen1mod.so
$(objpfx)tst-audit1.out: $(objpfx)tst-auditmod1.so
tst-audit1-ENV = LD_AUDIT=$(objpfx)tst-auditmod1.so
$(objpfx)tst-audit2: $(libdl)
$(objpfx)tst-audit2.out: $(objpfx)tst-auditmod1.so $(objpfx)tst-auditmod9b.so
tst-audit2-ENV = LD_AUDIT=$(objpfx)tst-auditmod1.so
$(objpfx)tst-audit9: $(libdl)
$(objpfx)tst-audit9.out: $(objpfx)tst-auditmod9a.so $(objpfx)tst-auditmod9b.so
tst-audit9-ENV = LD_AUDIT=$(objpfx)tst-auditmod9a.so
$(objpfx)tst-audit8: $(libm)
$(objpfx)tst-audit8.out: $(objpfx)tst-auditmod1.so
tst-audit8-ENV = LD_AUDIT=$(objpfx)tst-auditmod1.so
$(objpfx)tst-global1: $(libdl)
$(objpfx)tst-global1.out: $(objpfx)testobj6.so $(objpfx)testobj2.so
$(objpfx)order2: $(libdl)
$(objpfx)order2.out: $(objpfx)order2mod1.so $(objpfx)order2mod2.so
$(objpfx)order2-cmp.out: $(objpfx)order2.out
$(objpfx)order2mod1.so: $(objpfx)order2mod4.so
$(objpfx)order2mod4.so: $(objpfx)order2mod3.so
$(objpfx)order2mod2.so: $(objpfx)order2mod3.so
order2mod2.so-no-z-defs = yes
LDFLAGS-order2mod1.so = $(no-as-needed)
LDFLAGS-order2mod2.so = $(no-as-needed)
tst-stackguard1-ARGS = --command "$(host-test-program-cmd) --child"
tst-stackguard1-static-ARGS = --command "$(objpfx)tst-stackguard1-static --child"
tst-ptrguard1-ARGS = --command "$(host-test-program-cmd) --child"
tst-ptrguard1-static-ARGS = --command "$(objpfx)tst-ptrguard1-static --child"
$(objpfx)tst-leaks1: $(libdl)
$(objpfx)tst-leaks1-mem.out: $(objpfx)tst-leaks1.out
$(objpfx)tst-leaks1-static: $(common-objpfx)dlfcn/libdl.a
$(objpfx)tst-leaks1-static-mem.out: $(objpfx)tst-leaks1-static.out
tst-leaks1-ENV = MALLOC_TRACE=$(objpfx)tst-leaks1.mtrace
tst-leaks1-static-ENV = MALLOC_TRACE=$(objpfx)tst-leaks1-static.mtrace
$(objpfx)tst-addr1: $(libdl)
$(objpfx)tst-thrlock: $(libdl) $(shared-thread-library)
$(objpfx)tst-dlopen-aout: $(libdl) $(shared-thread-library)
LDFLAGS-ifuncmain3 = -Wl,-export-dynamic
$(objpfx)ifuncmain1pie: $(objpfx)ifuncmod1.so
$(objpfx)ifuncmain1staticpie: $(objpfx)ifuncdep1pic.o
$(objpfx)ifuncmain1vispie: $(objpfx)ifuncmod1.so
$(objpfx)ifuncmain5pie: $(objpfx)ifuncmod5.so
$(objpfx)ifuncmain6pie: $(objpfx)ifuncmod6.so
$(objpfx)ifuncmain1: $(addprefix $(objpfx),ifuncmod1.so)
$(objpfx)ifuncmain1pic: $(addprefix $(objpfx),ifuncmod1.so)
$(objpfx)ifuncmain1staticpic: $(addprefix $(objpfx),ifuncdep1pic.o)
$(objpfx)ifuncmain1static: $(addprefix $(objpfx),ifuncdep1.o)
$(objpfx)ifuncmain1picstatic: $(addprefix $(objpfx),ifuncdep1pic.o)
$(objpfx)ifuncmain1vis: $(addprefix $(objpfx),ifuncmod1.so)
$(objpfx)ifuncmain1vispic: $(addprefix $(objpfx),ifuncmod1.so)
$(objpfx)ifuncmain2: $(addprefix $(objpfx),ifuncdep2.o)
$(objpfx)ifuncmain2pic: $(addprefix $(objpfx),ifuncdep2pic.o)
$(objpfx)ifuncmain2static: $(addprefix $(objpfx),ifuncdep2.o)
$(objpfx)ifuncmain2picstatic: $(addprefix $(objpfx),ifuncdep2pic.o)
$(objpfx)ifuncmain3: $(libdl)
$(objpfx)ifuncmain3.out: $(objpfx)ifuncmod3.so
$(objpfx)ifuncmain5: $(addprefix $(objpfx),ifuncmod5.so)
$(objpfx)ifuncmain5pic: $(addprefix $(objpfx),ifuncmod5.so)
$(objpfx)ifuncmain5static: $(addprefix $(objpfx),ifuncdep5.o)
$(objpfx)ifuncmain5staticpic: $(addprefix $(objpfx),ifuncdep5pic.o)
$(objpfx)ifuncmain5picstatic: $(addprefix $(objpfx),ifuncdep5pic.o)
$(objpfx)tst-unique1: $(libdl)
$(objpfx)tst-unique1.out: $(objpfx)tst-unique1mod1.so 			  $(objpfx)tst-unique1mod2.so
$(objpfx)tst-unique2: $(libdl) $(objpfx)tst-unique2mod1.so
$(objpfx)tst-unique2.out: $(objpfx)tst-unique2mod2.so
$(objpfx)tst-unique3: $(libdl) $(objpfx)tst-unique3lib.so
$(objpfx)tst-unique3.out: $(objpfx)tst-unique3lib2.so
$(objpfx)tst-unique4: $(objpfx)tst-unique4lib.so
$(objpfx)tst-nodelete: $(libdl)
$(objpfx)tst-nodelete.out: $(objpfx)tst-nodelete-uniquemod.so 			   $(objpfx)tst-nodelete-rtldmod.so 			   $(objpfx)tst-nodelete-zmod.so
LDFLAGS-tst-nodelete = -rdynamic
LDFLAGS-tst-nodelete-zmod.so = -Wl,--enable-new-dtags,-z,nodelete
$(objpfx)tst-nodelete2: $(libdl)
$(objpfx)tst-nodelete2.out: $(objpfx)tst-nodelete2mod.so
LDFLAGS-tst-nodelete2 = -rdynamic
$(objpfx)tst-initorder-cmp.out: tst-initorder.exp $(objpfx)tst-initorder.out
$(objpfx)tst-initorder2: $(objpfx)tst-initorder2a.so $(objpfx)tst-initorder2d.so $(objpfx)tst-initorder2c.so
$(objpfx)tst-initorder2a.so: $(objpfx)tst-initorder2b.so
$(objpfx)tst-initorder2b.so: $(objpfx)tst-initorder2c.so
$(objpfx)tst-initorder2c.so: $(objpfx)tst-initorder2d.so
LDFLAGS-tst-initorder2 = $(no-as-needed)
LDFLAGS-tst-initorder2a.so = $(no-as-needed)
LDFLAGS-tst-initorder2b.so = $(no-as-needed)
LDFLAGS-tst-initorder2c.so = $(no-as-needed)
$(objpfx)tst-initorder2-cmp.out: tst-initorder2.exp $(objpfx)tst-initorder2.out
$(objpfx)tst-relsort1: $(libdl)
$(objpfx)tst-relsort1mod1.so: $(libm) $(objpfx)tst-relsort1mod2.so
$(objpfx)tst-relsort1mod2.so: $(libm)
$(objpfx)tst-relsort1.out: $(objpfx)tst-relsort1mod1.so 			   $(objpfx)tst-relsort1mod2.so
$(objpfx)tst-unused-dep.out: $(objpfx)testobj1.so
$(objpfx)tst-unused-dep-cmp.out: $(objpfx)tst-unused-dep.out
$(objpfx)tst-audit11.out: $(objpfx)tst-auditmod11.so $(objpfx)tst-audit11mod1.so
$(objpfx)tst-audit11: $(libdl)
tst-audit11-ENV = LD_AUDIT=$(objpfx)tst-auditmod11.so
$(objpfx)tst-audit11mod1.so: $(objpfx)tst-audit11mod2.so
LDFLAGS-tst-audit11mod2.so = -Wl,--version-script=tst-audit11mod2.map,-soname,tst-audit11mod2.so
$(objpfx)tst-audit12.out: $(objpfx)tst-auditmod12.so $(objpfx)tst-audit12mod1.so $(objpfx)tst-audit12mod3.so
$(objpfx)tst-audit12: $(libdl)
tst-audit12-ENV = LD_AUDIT=$(objpfx)tst-auditmod12.so
$(objpfx)tst-audit12mod1.so: $(objpfx)tst-audit12mod2.so
LDFLAGS-tst-audit12mod2.so = -Wl,--version-script=tst-audit12mod2.map
tst-prelink-ENV = LD_TRACE_PRELINKING=1
$(objpfx)tst-prelink-conflict.out: $(objpfx)tst-prelink.out
$(objpfx)tst-prelink-cmp.out: tst-prelink.exp 			      $(objpfx)tst-prelink-conflict.out
