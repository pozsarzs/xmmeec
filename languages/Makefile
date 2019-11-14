# +----------------------------------------------------------------------------+
# | XMMEEC v0.1 * Environment characteristics editor                           |
# | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>           |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

languages = hu

all:

clean:

install:
	@echo -n "- Installing message files..."
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.mo ]; \
	  then \
	    $(install) -d $(localedir)/$$x/LC_MESSAGES; \
	    $(install) -m $(txtmode) $(name)_$$x.mo $(localedir)/$$x/LC_MESSAGES; \
	    mv $(localedir)/$$x/LC_MESSAGES/$(name)_$$x.mo $(localedir)/$$x/LC_MESSAGES/$(name).mo ; \
	  fi; \
	done
	@echo "done."

uninstall:
	@echo -n "- Removing message files..."
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.mo ]; \
	  then \
	    $(rm) $(localedir)/$$x/LC_MESSAGES/$(name).mo; \
	  fi; \
	done
	@echo "done."

