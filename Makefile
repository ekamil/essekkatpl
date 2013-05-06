SHELL       := /usr/bin/zsh
RSYNC    := rsync --delete-before -r

MEGI_SSH_HOST := hertz
MEGI_URL      := http://www1.hertz.megiteam.pl
MEGI_WWW_PATH := ~/essekkat.pl

LAO_SSH_HOST := lao
LAO_URL      := http://essekkat.pl
LAO_WWW_PATH := ~/public_html

CV: www/cv_en.html www/cv_pl.html


all: clean cv deploy

dist: clean clean-remote deploy

cv: $(CV)

$(CV):
	cd resume && make
	cp resume/build/cv* www/
	touch $(CV)

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
	touch www/_site

serve: _site
	cd www && blogofile serve 8080

clean:	
	@-rm -r www/_site
	@-rm www/files/cv_*.pdf
	@-rm www/cv_*
	@-rm -r resume/build
