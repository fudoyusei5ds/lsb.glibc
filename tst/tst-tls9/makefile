CC      = gcc                    
LIBDIR	= $(TET_ROOT)/lib/tet3
INCDIR	= $(TET_ROOT)/inc/tet3
VSXDIR  = $(TET_ROOT)/test_sets/SRC/INC
VSXLIB  = $(TET_ROOT)/test_sets/SRC/LIB
DEFINES = -D_GNU_SOURCE         
ARGS    = -DFILENAME=\"tst-tls9\"          

CFLAGS	= -I$(INCDIR) -I$(VSXDIR) $(DEFINES) $(ARGS)   
LIBS = $(VSXLIB)/genlib.a $(VSXLIB)/vlib.a $(LIBDIR)/libapi.a   
SYSLIBS =   

################################################### 

all:	tst-tls9 
	@chmod a+x  tst-tls9 

tst-tls9:	../../lsb_test-skeleton.c   
	$(CC) $(CFLAGS) -o $@  $< $(LIBDIR)/tcm.o $(VSXLIB)/startup.o $(LIBS)    
