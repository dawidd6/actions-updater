PROGRAM = actions-updater
PREFIX = /usr
DESTDIR =

all:
	@echo "Run make install"

.PHONY install:
	@echo '#!/usr/bin/env ruby' | cat - lib.rb main.rb > $(PROGRAM)
	@sed -i '/^require_relative.*/d' $(PROGRAM)
	@install -d $(DESTDIR)$(PREFIX)/bin
	@install --mode 755 $(PROGRAM) $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)