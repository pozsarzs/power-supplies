# +----------------------------------------------------------------------------+
# | Power Supplies v0.4.1 * Power supply calculator                            |
# | Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile for help files                                                    |
# +----------------------------------------------------------------------------+

include ../Makefile.global

all:

clean:

install:
	@echo -n "- Installing help files..."
	@$(install) -d $(datarootdir)/$(name)/help/
	@$(install) -m $(txtmode) *.html $(datarootdir)/$(name)/help/
	@$(install) -m $(txtmode) *.css $(datarootdir)/$(name)/help/
	@echo "done."

uninstall:
	@echo -n "- Removing help files..."
	@$(rm) $(datarootdir)/$(name)/help/*.html
	@$(rm) $(datarootdir)/$(name)/help/*.css
	@rmdir $(datarootdir)/$(name)/help/
	@rmdir $(datarootdir)/$(name)/
	@echo "done."
