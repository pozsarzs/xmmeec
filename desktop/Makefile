# +----------------------------------------------------------------------------+
# | XMMEEC v0.3 * Environment characteristic editor for MMxD devices           |
# | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>       |
# | Makefile                                                                   |
# | Makefile for desktop files                                                 |
# +----------------------------------------------------------------------------+

include ../Makefile.global

desktopfiles= `ls *.desktop`
iconfiles = `ls *.xpm`

all:

clean:

install:
	@echo -n "- Installing desktop files..."
	@$(install) -d $(datarootdir)/applications
	@for x in $(desktopfiles); do \
	  if [ -e $$x ]; then $(install) -m $(txtmode) $$x $(datarootdir)/applications/; fi; \
	done
	@echo "done."
	@echo -n "- Installing icon files..."
	@$(install) -d $(datarootdir)/pixmaps
	@for x in $(iconfiles); do \
	  if [ -e $$x ]; then $(install) -m $(txtmode) $$x $(datarootdir)/pixmaps/; fi; \
	done
	@echo "done."

uninstall:
	@echo -n "- Removing desktop files..."
	@for x in $(desktopfiles); do \
	  if [ -e $$x ]; then $(rm) $(datarootdir)/applications/$$x; fi; \
	done
	@echo "done."
	@echo -n "- Removing icon files..."
	@for x in $(iconfiles); do \
	  if [ -e $$x ]; then $(rm) $(datarootdir)/pixmaps/$$x; fi; \
	done
	@echo "Done."

