EPREFIX ?=

PN = binutils-config
PV = git
P = $(PN)-$(PV)

PREFIX = $(EPREFIX)/usr
BINDIR = $(PREFIX)/bin
DOCDIR = $(PREFIX)/share/doc/$(P)
ESELECTDIR = $(PREFIX)/share/eselect/modules
MANDIR = $(PREFIX)/share/man

MKDIR_P = mkdir -p -m 755
INSTALL_EXE = install -m 755
INSTALL_DATA = install -m 644

all: # no-op

install: all
	$(MKDIR_P) $(DESTDIR)$(BINDIR) $(DESTDIR)$(DOCDIR) $(DESTDIR)$(ESELECTDIR) $(DESTDIR)$(MANDIR)/man8
	$(INSTALL_EXE)  src/binutils-config $(DESTDIR)$(BINDIR)
	$(INSTALL_DATA) README $(DESTDIR)$(DOCDIR)
	$(INSTALL_DATA) src/binutils.eselect $(DESTDIR)$(ESELECTDIR)
	$(INSTALL_DATA) src/binutils-config.8 $(DESTDIR)$(MANDIR)/man8

dist:
	@if [ "$(PV)" = "git" ] ; then \
		printf "please run: make dist PV=xxx\n(where xxx is a git tag)\n" ; \
		exit 1 ; \
	fi
	git archive --prefix=$(P)/ v$(PV) | xz > $(P).tar.xz

.PHONY: all clean dist install
