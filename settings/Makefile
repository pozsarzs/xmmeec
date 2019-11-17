# +----------------------------------------------------------------------------+
# | XMMEEC v0.1 * Environment characteristics editor                           |
# | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>           |
# | Makefile                                                                   |
# | Makefile for configuration files                                           |
# +----------------------------------------------------------------------------+

include ../Makefile.global

cfgfiles= `ls | grep -v Makefile | grep -v ?? | grep -v sample`

all:

clean:

install:
	@echo -n "- Installing configuration files..."
	@$(install) -d $(sysconfdir)
	@for x in $(cfgfiles); do \
	  if [ -e $$x ]; then $(install) -m $(txtmode) $$x $(sysconfdir); fi; \
	done
	@echo "done."

uninstall:
	@echo -n "- Removing configuration files..."
	@for x in $(cfgfiles); do \
	  if [ -e $$x ]; then $(rm) $(sysconfdir)/$$x; fi; \
	done
	@rmdir $(sysconfdir)/$(name)
	@echo "done."
