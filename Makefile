PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

all: install

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f = ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/=
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f =.1 ${DESTDIR}${MANPREFIX}/man1
	cp -f menu-calc.1 ${DESTDIR}${MANPREFIX}/man1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/=.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/menu-calc.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/=
	rm -f ${DESTDIR}${MANPREFIX}/man1/=.1
	rm -f ${DESTDIR}${MANPREFIX}/man1/menu-calc.1

test:
	man -l doc/menu-calc.1

.PHONY: all install uninstall test
