# $FreeBSD$

BINDIR=	${SHAREDIR}/man/pt_BR.UTF-8

SUBDIR=	man4

distrib-dirs:
	mkdir -p ${DESTDIR}${BINDIR}
	mtree -deU -f ${.CURDIR}/DOCBR.man.dist -p ${DESTDIR}${BINDIR}

makedb:
	makewhatis ${DESTDIR}${BINDIR}

beforeinstall: distrib-dirs
afterinstall: makedb

.include <bsd.subdir.mk>
