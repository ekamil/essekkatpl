# configuration
gh_pages_repo = git@github.com:ekamil/ekamil.github.io.git
gh_pages_dir = gh_pages

revision = $(shell git rev-parse --short=6 HEAD)

langs = pl en
formats = pdf docx html latex

##### variables
www=$(PWD)/www
dist=$(PWD)/www/dist
app=$(PWD)/www/app

standalone = $(foreach l, $(langs), $(app)/cv-$(l).s.html)
files = $(foreach f, $(formats), $(foreach l, $(langs), $(app)/files/cv-$(l).$(f) ) )
gpg = $(app)/files/kamil_e.asc $(app)/files/debian.asc $(app)/files/mobile.asc

rsync := rsync --delete-before -r


## default target
default: deploy


#### generate static files
cv:
	cd resume && make langs='$(langs)' formats='$(formats)' out=$(app)/files
	cd resume && make langs='$(langs)' formats=s.html out=$(app)

.PHONY: cv

gpg:
	gpg --export --armor 598C2A2D > $(app)/files/kamil_e.asc
	gpg --export --armor 6AEEC2FD > $(app)/files/mobile.asc
	gpg --export --armor 90EB7B11 > $(app)/files/debian.asc

.PHONY: gpg

static: cv gpg
	@touch  $(standalone) $(files) $(gpg)

clean-static:
	-rm  $(standalone) $(files) $(gpg)

.PHONY: static clean-static
#### prerequisites for build
$(www)/node_modules:
	cd $(www) && npm install

$(app)/bower_components:
	cd $(www) && bower install

prereq: $(app)/bower_components $(www)/node_modules
	@touch $(app)/bower_components $(www)/node_modules

### build itself
$(dist): static prereq
	cd $(www) && grunt build

build: $(dist)

## deployment
submodule:
	-git submodule add $(gh_pages_repo) $(gh_pages_dir)
	git submodule update $(gh_pages_dir)

deploy: build submodule
	$(rsync) $(dist)/ $(gh_pages_dir)/
	$(MAKE) commit

commit:
	cd $(gh_pages_dir) && git add .
	cd $(gh_pages_dir) && git commit -am 'Makefile commit, rev $(revision)'
	cd $(gh_pages_dir) && git push origin master

.PHONY: deploy
####

clean: clean-static
	@-rm -rf $(www)/.sass-cache $(www)/.tmp $(dist)
	git clean -xdf $(www)
.PHONY: clean
