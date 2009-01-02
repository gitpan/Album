# Generic Makefile for albums.

HERE	= .
TOOLS	= $(HOME)/src/album/src
DATA	= $(HOME)/src/album/data
#CAMERA	= /mnt/camera
CAMERA	?= /mnt/mstick
DCIM	?= dcim/101msdcf
DSC	?= $(CAMERA)/$(DCIM)
RAW	?= $(HERE)/$(DCIM)
OPTS	?=
PERL	?= perl
WCAPTION ?= tc
# UPLOAD  = warpnet:vromans.org/johan/albums/20080831/
UPLOAD  ?= /tmp/

IMPORT	= $(shell test -d $(DCIM) && echo "--dcim=$(DCIM)")

default : update

fetch :	mountc _fetch umountc

mountc :
	-mount $(CAMERA)

_fetch :
	rsync -av --modify-window=1 --exclude=dsc00000.jpg \
	    $(DSC)/ $(RAW)/
	find $(RAW) -type f -perm +333 -print -exec chmod 0444 {} \;

umountc :
	-umount $(CAMERA)
	-eject $(CAMERA)

update :
	$(PERL) -w $(TOOLS)/album.pl $(OPTS) --verbose --update $(IMPORT) $(HERE)

clobber :
	$(PERL) -w $(TOOLS)/album.pl $(OPTS) --verbose --clobber --update $(IMPORT) $(HERE)

export-web :
	$(PERL) -w $(TOOLS)/album.pl $(OPTS) --verbose --mediumonly --caption=$(WCAPTION) $(HERE)
	rm -f web.zip
	zip -rn .jpg web.zip index*.html icons css medium index journal

upload :
	$(PERL) -w $(TOOLS)/album.pl $(OPTS) --verbose --mediumonly --caption=$(WCAPTION) $(HERE)
	rsync -avH --delete --delete-excluded \
	  --exclude Makefile --exclude info.dat --exclude shellrun.exe \
	  --exclude autorun.inf --exclude '.cache' --include '.htaccess' --exclude '*~' \
	  --exclude web.zip --exclude dcim --exclude large \
	  ./ $(UPLOAD)/

init ::
	mkdir -p $(DCIM)
	: ln -s $(TOOLS)/shellrun.exe .
	: ln -s $(TOOLS)/autorun.inf .
	test -f Makefile || echo "include $(TOOLS)/generic.mk" > Makefile
	test -f info.dat || { \
		dir="`basename \`pwd\``"; \
		touch $(DATA)/$$dir.dat; \
		ln -s $(DATA)/$$dir.dat info.dat; \
		echo "!title $$dir" > info.dat; \
	}

init-nolinks ::
	mkdir -p $(DCIM)
	cp $(TOOLS)/shellrun.exe .
	cp $(TOOLS)/autorun.inf .
	test -f Makefile || cp $(TOOLS)/generic.mk Makefile
	test -f info.dat || { \
		dir="`basename \`pwd\``"; \
		echo "!title $$dir" > info.dat; \
	}

gimp :
	@echo -n "Number? "; read a; \
	cd large; file=`ls *$$a.jpg`; \
	echo $$file; \
	cat $$file > xx; rm -f $$file; mv xx $$file; \
	gimp $$file; \
	cd ..; rm -f medium/$$file index/$$file .cache

clean ::
	rm -f .cache *png index*html large/*html *~
	rm -f shellrun.exe ShellRun.exe autorun.inf
	rm -fr icons css images medium thumbnails .xvpics

realclean :: clean
	rm -f `readlink info.dat` info.dat 
