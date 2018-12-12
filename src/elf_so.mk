
#############################################
# 所有动态链接库

modules-names=testobj1 testobj2 testobj3 testobj4 testobj5 testobj6 \
		testobj1_1 failobj constload2 constload3 unloadmod \
		dep1 dep2 dep3 dep4 vismod1 vismod2 vismod3 \
		nodelmod1 nodelmod2 nodelmod3 nodelmod4 \
		nodel2mod1 nodel2mod2 nodel2mod3 \
		nodlopenmod nodlopenmod2 filtmod1 filtmod2 \
		reldepmod1 reldepmod2 reldepmod3 reldepmod4 nextmod1 nextmod2 \
		reldep4mod1 reldep4mod2 reldep4mod3 reldep4mod4 \
		neededobj1 neededobj2 neededobj3 neededobj4 \
		neededobj5 neededobj6 firstobj globalmod1 \
		unload2mod unload2dep ltglobmod1 ltglobmod2 pathoptobj \
		dblloadmod1 dblloadmod2 dblloadmod3 reldepmod5 reldepmod6 \
		reldep6mod0 reldep6mod1 reldep6mod2 reldep6mod3 reldep6mod4 \
		reldep7mod1 reldep7mod2 \
		tst-tlsmod1 tst-tlsmod2 tst-tlsmod3 tst-tlsmod4 \
		tst-tlsmod5 tst-tlsmod6 tst-tlsmod7 tst-tlsmod8 \
		tst-tlsmod9 tst-tlsmod10 tst-tlsmod11 tst-tlsmod12 \
		tst-tlsmod13 tst-tlsmod13a tst-tlsmod14a tst-tlsmod14b \
		tst-tlsmod15a tst-tlsmod15b tst-tlsmod16a tst-tlsmod16b \
		tst-tlsmod17b\
		tst-tls19mod1 tst-tls19mod2 tst-tls19mod3 \
		circlemod1 circlemod1a circlemod2 circlemod2a \
		circlemod3 circlemod3a \
		reldep8mod1 reldep8mod2 reldep8mod3 \
		reldep9mod1 reldep9mod2 reldep9mod3 \
		tst-alignmod tst-alignmod2 \
		 \
		tst-dlopenrpathmod tst-deep1mod1 tst-deep1mod2 tst-deep1mod3 \
		tst-dlmopen1mod tst-auditmod1 \
		unload3mod1 unload3mod2 unload3mod3 unload3mod4 \
		unload4mod1 unload4mod2 unload4mod3 unload4mod4 \
		unload6mod1 unload6mod2 unload6mod3 \
		unload7mod1 unload7mod2 \
		unload8mod1 unload8mod1x unload8mod2 unload8mod3 \
		order2mod1 order2mod2 order2mod3 order2mod4 \
		tst-unique1mod1 tst-unique1mod2 \
		tst-unique2mod1 tst-unique2mod2 \
		tst-auditmod9a tst-auditmod9b \
		tst-initordera1 tst-initorderb1 \
		tst-initordera2 tst-initorderb2 \
		tst-initordera3 tst-initordera4 \
		tst-relsort1mod1 tst-relsort1mod2 tst-array2dep \
		tst-array5dep tst-null-argv-lib \
		tst-tlsalign-lib tst-nodelete-opened-lib tst-nodelete2mod \
		tst-audit11mod1 tst-audit11mod2 tst-auditmod11 \
		tst-audit12mod1 tst-audit12mod2 tst-audit12mod3 tst-auditmod12
modules-names += tst-protected1moda tst-protected1modb
modules-names += tst-piemod1

####################################################
# 以下两组动态链接库有些特殊, 需要单独生成

$(objpfx)tst-initorder2a.so: $(objpfx)tst-initorder2b.so
$(objpfx)tst-initorder2b.so: $(objpfx)tst-initorder2c.so
$(objpfx)tst-initorder2c.so: $(objpfx)tst-initorder2d.so
LDFLAGS-tst-initorder2a.so = $(no-as-needed)
LDFLAGS-tst-initorder2b.so = $(no-as-needed)
LDFLAGS-tst-initorder2c.so = $(no-as-needed)

$(objpfx)tst-initorder2a.os: tst-initorder2.c
	$(compile-command.c) -DNAME=\"a\"
$(objpfx)tst-initorder2a.so: \
		$(objpfx)tst-initorder2a.os $(shlib-lds) $(link-libs-deps)
	$(build-module)

$(objpfx)tst-initorder2b.os: tst-initorder2.c
	$(compile-command.c) -DNAME=\"b\"
$(objpfx)tst-initorder2b.so: \
		$(objpfx)tst-initorder2b.os $(shlib-lds) $(link-libs-deps)
	$(build-module)

$(objpfx)tst-initorder2c.os: tst-initorder2.c
	$(compile-command.c) -DNAME=\"c\"
$(objpfx)tst-initorder2c.so: \
		$(objpfx)tst-initorder2c.os $(shlib-lds) $(link-libs-deps)
	$(build-module)

$(objpfx)tst-initorder2d.os: tst-initorder2.c
	$(compile-command.c) -DNAME=\"d\"
$(objpfx)tst-initorder2d.so: \
		$(objpfx)tst-initorder2d.os $(shlib-lds) $(link-libs-deps)
	$(build-module)


tlsmod17a-suffixes = 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
tlsmod18a-suffixes = 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
tlsmod17a-modules = $(addprefix tst-tlsmod17a, $(tlsmod17a-suffixes))
tlsmod18a-modules = $(addprefix tst-tlsmod18a, $(tlsmod17a-suffixes))

$(patsubst %,$(objpfx)%.os,$(tlsmod17a-modules)): $(objpfx)tst-tlsmod17a%.os: tst-tlsmod17a.c
	$(compile-command.c) -DN=$* -fPIC
$(patsubst %,$(objpfx)%.so,$(tlsmod17a-modules)): $(objpfx)tst-tlsmod17a%.so: $(objpfx)tst-tlsmod17a%.os
	$(build-module)

$(patsubst %,$(objpfx)%.os,$(tlsmod18a-modules)): $(objpfx)tst-tlsmod18a%.os : tst-tlsmod18a.c
	$(compile-command.c) -DN=$* -fPIC
$(patsubst %,$(objpfx)%.so,$(tlsmod18a-modules)): $(objpfx)tst-tlsmod18a%.so: $(objpfx)tst-tlsmod18a%.os
	$(build-module)

modules-extra-names = $(tlsmod17a-modules) $(tlsmod18a-modules)\
	$(patsubst %,tst-initorder2%,a b c d)

#################################################

$(objpfx)circlemod1.so: $(objpfx)circlemod2.so

$(objpfx)circlemod1a.so: $(objpfx)circlemod2a.so

$(objpfx)circlemod2.so: $(objpfx)circlemod3.so

circlemod2.so-no-z-defs = yes

$(objpfx)circlemod2a.so: $(objpfx)circlemod3a.so

circlemod3.so-no-z-defs = yes

circlemod3a.so-no-z-defs = yes

constload2.so-no-z-defs = yes

constload3.so-no-z-defs = yes

$(objpfx)dblloadmod1.so: $(objpfx)dblloadmod3.so

$(objpfx)dblloadmod2.so: $(objpfx)dblloadmod3.so

dblloadmod3.so-no-z-defs = yes

$(objpfx)dep1.so: $(objpfx)dep2.so $(objpfx)dep4.so

$(objpfx)dep2.so: $(objpfx)dep3.so $(objpfx)dep4.so

$(objpfx)dep4.so: $(objpfx)dep3.so

$(objpfx)failobj.so: $(objpfx)testobj6.so

failobj.so-no-z-defs = yes

$(objpfx)filtmod1.so: $(objpfx)filtmod1.os $(objpfx)filtmod2.so

$(objpfx)firstobj.so: $(shared-thread-library)

$(objpfx)globalmod1.so: $(libdl)

ifuncmod1.so-no-z-defs = yes

ifuncmod5.so-no-z-defs = yes

ifuncmod6.so-no-z-defs = yes

$(objpfx)ltglobmod2.so: $(libdl)

ltglobmod2.so-no-z-defs = yes

$(objpfx)neededobj1.so: $(libdl)

$(objpfx)neededobj2.so: $(objpfx)neededobj1.so $(libdl)

$(objpfx)neededobj3.so: $(objpfx)neededobj1.so $(objpfx)neededobj2.so $(libdl)

$(objpfx)neededobj4.so: $(objpfx)neededobj1.so $(objpfx)neededobj2.so 			$(objpfx)neededobj3.so $(libdl)

$(objpfx)neededobj6.so: $(objpfx)neededobj5.so

$(objpfx)nextmod1.so: $(libdl)

LDFLAGS-nodel2mod2.so = -Wl,--enable-new-dtags,-z,nodelete

nodel2mod2.so-no-z-defs = yes

$(objpfx)nodel2mod3.so: $(objpfx)nodel2mod1.so $(objpfx)nodel2mod2.so

LDFLAGS-nodel2mod3.so = $(no-as-needed)

LDFLAGS-nodelmod1.so = -Wl,--enable-new-dtags,-z,nodelete

nodelmod1.so-no-z-defs = yes

nodelmod2.so-no-z-defs = yes

$(objpfx)nodelmod3.so: $(objpfx)nodelmod4.so

LDFLAGS-nodelmod4.so = -Wl,--enable-new-dtags,-z,nodelete

nodelmod4.so-no-z-defs = yes

LDFLAGS-nodlopenmod.so = -Wl,--enable-new-dtags,-z,nodlopen

$(objpfx)nodlopenmod2.so: $(objpfx)nodlopenmod.so

$(objpfx)order2mod1.so: $(objpfx)order2mod4.so

LDFLAGS-order2mod1.so = $(no-as-needed)

$(objpfx)order2mod2.so: $(objpfx)order2mod3.so

LDFLAGS-order2mod2.so = $(no-as-needed)

order2mod2.so-no-z-defs = yes

$(objpfx)order2mod4.so: $(objpfx)order2mod3.so

$(objpfx)reldep4mod1.so: $(objpfx)reldep4mod3.so

$(objpfx)reldep4mod2.so: $(objpfx)reldep4mod4.so

reldep4mod2.so-no-z-defs = yes

reldep4mod4.so-no-z-defs = yes

$(objpfx)reldep6mod1.so: $(objpfx)reldep6mod0.so

LDFLAGS-reldep6mod1.so = $(no-as-needed)

$(objpfx)reldep6mod2.so: $(objpfx)reldep6mod1.so

$(objpfx)reldep6mod3.so: $(objpfx)reldep6mod2.so

$(objpfx)reldep6mod4.so: $(objpfx)reldep6mod1.so

LDFLAGS-reldep6mod4.so = $(no-as-needed)

reldep8mod2.so-no-z-defs = yes

$(objpfx)reldep8mod3.so: $(objpfx)reldep8mod1.so $(objpfx)reldep8mod2.so

LDFLAGS-reldep8mod3.so = $(no-as-needed)

reldep9mod1.so-no-z-defs = yes

$(objpfx)reldep9mod2.so: $(objpfx)reldep9mod1.so

$(objpfx)reldep9mod3.so: $(objpfx)reldep9mod1.so $(objpfx)reldep9mod2.so

reldepmod2.so-no-z-defs = yes

reldepmod3.so-no-z-defs = yes

reldepmod4.so-no-z-defs = yes

$(objpfx)reldepmod5.so: $(objpfx)reldepmod2.so

LDFLAGS-reldepmod5.so = $(no-as-needed)

$(objpfx)reldepmod6.so: $(objpfx)reldepmod2.so

$(objpfx)testobj1.so: $(libdl)

testobj1.so-no-z-defs = yes

$(objpfx)testobj1_1.so: $(objpfx)testobj1.so $(libdl)

$(objpfx)testobj2.so: $(objpfx)testobj1.so $(libdl)

$(objpfx)testobj3.so: $(libdl)

testobj3.so-no-z-defs = yes

$(objpfx)testobj4.so: $(libdl)

testobj4.so-no-z-defs = yes

$(objpfx)testobj5.so: $(libdl)

testobj5.so-no-z-defs = yes

$(objpfx)testobj6.so: $(objpfx)testobj1.so $(objpfx)testobj2.so $(libdl)

testobj6.so-no-z-defs = yes

$(objpfx)tst-audit11mod1.so: $(objpfx)tst-audit11mod2.so

LDFLAGS-tst-audit11mod2.so = -Wl,--version-script=tst-audit11mod2.map,-soname,tst-audit11mod2.so

$(objpfx)tst-audit12mod1.so: $(objpfx)tst-audit12mod2.so

LDFLAGS-tst-audit12mod2.so = -Wl,--version-script=tst-audit12mod2.map

tst-auditmod9a.so-no-z-defs = yes

tst-auditmod9b.so-no-z-defs = yes

$(objpfx)tst-deep1mod2.so: $(objpfx)tst-deep1mod3.so

tst-deep1mod3.so-no-z-defs = yes

$(objpfx)tst-dlmopen1mod.so: $(libdl)

$(objpfx)tst-dlopenrpathmod.so: $(libdl)

LDFLAGS-tst-dlopenrpathmod.so += -Wl,-rpath,\$$ORIGIN/test-subdir

$(objpfx)tst-initordera2.so: $(objpfx)tst-initordera1.so

LDFLAGS-tst-initordera2.so = $(no-as-needed)

$(objpfx)tst-initordera3.so: $(objpfx)tst-initorderb2.so $(objpfx)tst-initorderb1.so

LDFLAGS-tst-initordera3.so = $(no-as-needed)

$(objpfx)tst-initordera4.so: $(objpfx)tst-initordera3.so

LDFLAGS-tst-initordera4.so = $(no-as-needed)

$(objpfx)tst-initorderb2.so: $(objpfx)tst-initorderb1.so $(objpfx)tst-initordera2.so

LDFLAGS-tst-initorderb2.so = $(no-as-needed)

tst-nodelete2mod.so-no-z-defs = yes

tst-protected1modb.so-no-z-defs = yes

$(objpfx)tst-relsort1mod1.so: $(libm) $(objpfx)tst-relsort1mod2.so

$(objpfx)tst-relsort1mod2.so: $(libm)

$(objpfx)tst-tls19mod1.so: $(objpfx)tst-tls19mod2.so $(objpfx)tst-tls19mod3.so

$(objpfx)tst-tls19mod3.so:

tst-tlsmod1.so-no-z-defs = yes

$(objpfx)tst-tlsmod10.so: $(objpfx)tst-tlsmod9.so

tst-tlsmod10.so-no-z-defs = yes

$(objpfx)tst-tlsmod12.so: $(objpfx)tst-tlsmod11.so

tst-tlsmod12.so-no-z-defs = yes

$(objpfx)tst-tlsmod13a.so: $(objpfx)tst-tlsmod13.so

tst-tlsmod14a.so-no-z-defs = yes

tst-tlsmod14b.so-no-z-defs = yes

tst-tlsmod15a.so-no-z-defs = yes

tst-tlsmod16b.so-no-z-defs = yes

$(objpfx)tst-tlsmod17b.so: $(patsubst %,$(objpfx)%.so,$(tlsmod17a-modules))

tst-tlsmod2.so-no-z-defs = yes

$(objpfx)tst-tlsmod3.so: $(objpfx)tst-tlsmod2.so

tst-tlsmod3.so-no-z-defs = yes

tst-tlsmod4.so-no-z-defs = yes

$(objpfx)tst-tlsmod5.so: 

LDFLAGS-tst-tlsmod5.so = -nostdlib $(no-as-needed)

$(objpfx)tst-tlsmod6.so:

LDFLAGS-tst-tlsmod6.so = -nostdlib $(no-as-needed)

tst-tlsmod7.so-no-z-defs = yes

$(objpfx)tst-tlsmod8.so: $(objpfx)tst-tlsmod7.so

tst-tlsmod8.so-no-z-defs = yes

tst-tlsmod9.so-no-z-defs = yes

$(objpfx)unload2mod.so: $(objpfx)unload2dep.so

$(objpfx)unload3mod1.so: $(objpfx)unload3mod3.so

$(objpfx)unload3mod2.so: $(objpfx)unload3mod3.so

$(objpfx)unload3mod3.so: $(objpfx)unload3mod4.so

unload3mod4.so-no-z-defs = yes

$(objpfx)unload4mod1.so: $(objpfx)unload4mod2.so $(objpfx)unload4mod3.so

LDFLAGS-unload4mod1.so = $(no-as-needed)

unload4mod1.so-no-z-defs = yes

$(objpfx)unload4mod2.so: $(objpfx)unload4mod4.so $(objpfx)unload4mod3.so

LDFLAGS-unload4mod2.so = $(no-as-needed)

$(objpfx)unload6mod1.so: $(libdl)

$(objpfx)unload6mod2.so: $(libdl)

$(objpfx)unload6mod3.so: $(libdl)

$(objpfx)unload7mod1.so: $(libdl)

$(objpfx)unload7mod2.so: $(objpfx)unload7mod1.so

$(objpfx)unload8mod1.so: $(objpfx)unload8mod2.so

$(objpfx)unload8mod2.so: $(objpfx)unload8mod3.so

$(objpfx)unload8mod3.so: $(libdl)
