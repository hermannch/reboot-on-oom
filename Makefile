SRC := src/reboot-on-oom

WITH_SYSTEMD ?=

DESTDIR=
BINDIR ?= /usr/bin
SYSTEMDDIR ?= /lib/systemd/system/

all:

check:
	-shfmt -d .
	-shellcheck $(shell shfmt -f src)

install:
	install -Dm0755 $(SRC) $(DESTDIR)$(BINDIR)/reboot-on-oom
ifneq ($(WITH_SYSTEMD),)
	install -Dm0644 aux/reboot-on-oom.service $(DESTDIR)$(SYSTEMDDIR)/reboot-on-oom.service
endif

uninstall:
	-rm $(DESTDIR)$(BINDIR)/reboot-on-oom 
	-rm $(DESTDIR)$(SYSTEMDDIR)/reboot-on-oom.service

.PHONY: all check install uninstall
