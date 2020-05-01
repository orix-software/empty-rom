AS=ca65
CC=cl65
LD=ld65
CFLAGS=-ttelestrat
LDFILES=
ROM=emptyrom

all : build
.PHONY : all

HOMEDIR=/home/travis/bin/
HOMEDIR_ORIX=/home/travis/build/orix-software/empty-rom/
ORIX_VERSION=1.0

SOURCE=src/empty-rom.asm

TELESTRAT_TARGET_RELEASE=release/telestrat
MYDATE = $(shell date +"%Y-%m-%d %H:%m")

ifdef TRAVIS_BRANCH
ifeq ($(TRAVIS_BRANCH), master)
RELEASE:=$(shell cat VERSION)
RELEASE:=$(shell echo RELEASE master)
else
RELEASE=alpha
RELEASE:=$(shell echo RELEASE alpha)
endif
endif

 
build: $(SOURCE)
	@date +'.define __DATE__ "%F %R"' > src/build.inc
	$(AS) $(CFLAGS) $(SOURCE) -o $(ROM).ld65
	$(LD) -tnone $(ROM).ld65 -o $(ROM).rom

test:
	mkdir -p build/usr/share/man/
	mkdir -p build/usr/share/emptyrom/
	cp $(ROM).rom build/usr/share/emptyrom/
	export ORIX_PATH=`pwd`
	cd build && tar -c * > ../$(ROM).tar &&	cd ..
	filepack  $(ROM).tar $(ROM).pkg
	gzip $(ROM).tar
	mv $(ROM).tar.gz $(ROM).tgz
	echo Branch $(TRAVIS_BRANCH) Release   $(RELEASE)
	php buildTestAndRelease/publish/publish2repo.php $(ROM).tgz ${hash} 6502 tgz $(RELEASE)

  
  


