# +----------------------------------------------------------------------------+
# | XMMEEC v0.1 * Environment characteristics editor                           |
# | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>           |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

languages = en hu

all:

clean:

install:
	@echo -n "- Installing manual files..."
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.1 ]; \
	  then \
	    $(install) -d $(mandir)/$$x/man1; \
	    $(install) -m $(txtmode) $(name)_$$x.1 $(mandir)/$$x/man1; \
	    mv $(mandir)/$$x/man1/$(name)_$$x.1 $(mandir)/$$x/man1/$(name).1 ; \
	  fi; \
	done
	@$(install) -d $(mandir)/man1;
	@mv $(mandir)/en/man1/* $(mandir)/man1
	@rmdir $(mandir)/en/man1/
	@rmdir $(mandir)/en
	@for x in $(languages); do \
	  if [ -e xedf_$$x.5 ]; \
	  then \
	    $(install) -d $(mandir)/$$x/man5; \
	    $(install) -m $(txtmode) xedf_$$x.5 $(mandir)/$$x/man5; \
	    mv $(mandir)/$$x/man5/xedf_$$x.5 $(mandir)/$$x/man5/xedf.5 ; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -e cxedf_$$x.5 ]; \
	  then \
	    $(install) -d $(mandir)/$$x/man5; \
	    $(install) -m $(txtmode) cxedf_$$x.5 $(mandir)/$$x/man5; \
	    mv $(mandir)/$$x/man5/cxedf_$$x.5 $(mandir)/$$x/man5/cxedf.5 ; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -e t2c_$$x.5 ]; \
	  then \
	    $(install) -d $(mandir)/$$x/man5; \
	    $(install) -m $(txtmode) t2c_$$x.5 $(mandir)/$$x/man5; \
	    mv $(mandir)/$$x/man5/t2c_$$x.5 $(mandir)/$$x/man5/t2c.5 ; \
	  fi; \
	done
	@$(install) -d $(mandir)/man5;
	@mv $(mandir)/en/man5/* $(mandir)/man5
	@rmdir $(mandir)/en/man5/
	@rmdir $(mandir)/en
	@echo "done."

uninstall:
	@echo -n "- Removing manual files..."
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.1 ]; \
	  then \
	    $(rm) $(mandir)/$$x/man1/$(name).1; \
	  fi; \
	done
	@$(rm) $(mandir)/man1/$(name).1;
	@for x in $(languages); do \
	  if [ -e xedf_$$x.5 ]; \
	  then \
	    $(rm) $(mandir)/$$x/man5/xedf.5; \
	    $(rm) $(mandir)/$$x/man5/cxedf.5; \
	    $(rm) $(mandir)/$$x/man5/t2c.5; \
	  fi; \
	done
	@$(rm) $(mandir)/man5/xedf.5;
	@$(rm) $(mandir)/man5/cxedf.5;
	@$(rm) $(mandir)/man5/t2c.5;
	@echo "done."

