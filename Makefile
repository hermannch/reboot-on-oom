SRC := src/reboot-on-oom

WITH_SYSTEMD ?=

DESTDIR ?=
PREFIX ?= /usr/local
BINDIR = bin
SYSTEMDDIR ?= /lib/systemd/system/

all:

check:
	-shfmt -d .
	-shellcheck $(shell shfmt -f src)

install:
	install -Dm0755 $(SRC) $(DESTDIR)/$(PREFIX)/$(BINDIR)/reboot-on-oom
ifneq ($(WITH_SYSTEMD),)
	install -Dm0644 aux/reboot-on-oom.service $(DESTDIR)/$(PREFIX)/$(SYSTEMDDIR)/reboot-on-oom.service
endif

uninstall:
	rm -f $(DESTDIR)/$(PREFIX)/$(BINDIR)/reboot-on-oom 
	rm -f $(DESTDIR)/$(PREFIX)/$(SYSTEMDDIR)/reboot-on-oom.service

.PHONY: all check install uninstall
