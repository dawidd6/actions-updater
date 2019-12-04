PROGRAM = actions-updater
PREFIX = /usr
DESTDIR =

$(PROGRAM):
	echo '#!/usr/bin/env ruby' | cat - lib.rb main.rb | egrep -v '^require_relative' > $(PROGRAM)

.PHONY install: $(PROGRAM)
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(PROGRAM) $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)