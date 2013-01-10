SHELL       := /usr/bin/zsh
RSYNC    := rsync --delete-before -r

CV_LIST   = pl en

MEGI_SSH_HOST := hertz
MEGI_URL      := http://www1.hertz.megiteam.pl
MEGI_WWW_PATH := ~/essekkat.pl

LAO_SSH_HOST := lao
LAO_URL      := http://essekkat.pl
LAO_WWW_PATH := ~/public_html


all: clean cv deploy

dist: clean clean-remote deploy

$(CV_LIST):
	rst2pdf --compressed --stylesheets=cv.style cv_$@.rst --output=www/files/cv_$@.pdf
	rst2html --stylesheet-path=www/css/style.css cv_$@.rst www/cv_$@.html

cv: $(CV_LIST)

deploy: deploy-lao deploy-megi

clean-remote: clean-remote-lao clean-remote-megi

deploy-megi:
	sed -i 's|site.url = .*|site.url = "$(MEGI_URL)"|' www/_config.py
	$(MAKE) _site
	$(RSYNC) www/_site/ $(MEGI_SSH_HOST):$(MEGI_WWW_PATH)/
	ssh $(MEGI_SSH_HOST) 'chmod -R 755 $(MEGI_WWW_PATH)'

clean-remote-megi:
	ssh $(MEGI_SSH_HOST) 'rm -r $(MEGI_WWW_PATH)/*'

deploy-lao:
	sed -i 's|site.url = .*|site.url = "$(LAO_URL)"|' www/_config.py
	$(MAKE) _site
	$(RSYNC) www/_site/ $(LAO_SSH_HOST):$(LAO_WWW_PATH)/
	ssh $(LAO_SSH_HOST) 'chmod -R 755 $(LAO_WWW_PATH)/'

clean-remote-lao:
	ssh $(LAO_SSH_HOST) 'rm -r $(LAO_WWW_PATH)/*'

_site:
	cd www && blogofile 'build'

serve: _site
	cd www && blogofile serve 8080

clean:	
	@-rm -r www/_site
	@-rm www/files/cv_*.pdf
	@-rm www/cv_*.html
