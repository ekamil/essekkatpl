CV_SRC   := $(shell find -name "*.rst")
CV_TRG   := files/cv_pl.pdf
CV_TRG   += files/cv_en.pdf

RSYNC    := rsync --delete-before -r

$(CV_TRG): $(CV_SRC)
	rst2pdf $< -co $@ -s _cv.style

_site: $(CV_TRG)
	blogofile 'build'

serve: _site
	blogofile serve 8080

clean:
	-rm -r _site
	-rm -r $(CV_TRG)

lao:
	$(MAKE) -f Makefile-lao clean deploy

megi:
	$(MAKE) -f Makefile-megi clean deploy

local:
	$(MAKE) -f Makefile-local clean deploy
