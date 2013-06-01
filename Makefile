SHELL := /usr/bin/zsh
RSYNC := rsync --delete-before -r

MEGI_SSH_HOST := hertz
MEGI_URL      := http://www1.hertz.megiteam.pl
MEGI_WWW_PATH := ~/essekkat.pl

all: clean cv deploy

dist: clean clean-remote deploy

cv:
	cd resume && make
	cp resume/build/cv* www/

clean-remote: clean-lao clean-megi

deploy:
	$(RSYNC) www/ $(MEGI_SSH_HOST):$(MEGI_WWW_PATH)/
	ssh $(MEGI_SSH_HOST) 'chmod -R 755 $(MEGI_WWW_PATH)'

clean-megi:
	ssh $(MEGI_SSH_HOST) 'rm -r $(MEGI_WWW_PATH)/*'

clean:	
	@-rm www/cv_*
	@-rm -r resume/build
