VERSION=1.0

all: doc
doc: squashfu.1

install: all
	@echo "installing squashfu to ${DESTDIR}/usr/bin"
	@mkdir -p ${DESTDIR}/usr/bin
	@cp squashfu ${DESTDIR}/usr/bin
	@chmod 755 ${DESTDIR}/usr/bin/squashfu
	@mkdir -p ${DESTDIR}/etc
	@cp squashfu.conf ${DESTDIR}/etc
	@chmod 644 ${DESTDIR}/etc/squashfu.conf
	@echo "installing man page to ${DESTDIR}${MANPREFIX}/man1"
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < squashfu.1 > ${DESTDIR}${MANPREFIX}/man1/squashfu.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/squashfu.1

uninstall:
	@echo "--> Your inventory and config files will not be deleted."
	@echo "Removing executable file from ${DESTDIR}/usr/bin"
	@rm -f ${DESTDIR}/usr/bin/squashfu
	@echo "Removing man page from ${DESTDIR}${MANPREFIX}/man1/squashfu.1"
	@rm -f ${DESTDIR}${MANPREFIX}/man1/squashfu.1

squashfu.1: README.pod
	pod2man --section=1 --center=" " --release=" " --name="SQUASHFU" --date="squashfu-${VERSION}" README.pod > squashfu.1

.PHONY: all doc install uninstall
