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


## default target
default: deploy


#### generate static files
cv:
	cd resume && make langs='$(langs)' formats='$(formats)' out=$(app)/files
	cd resume && make langs='$(langs)' formats=s.html out=$(app)

$(standalone): cv
	@touch $(standalone)

$(files): cv
	@touch $(files)

$(gpg):
	gpg --export --armor 76570E36 > $(app)/files/kamil_e.asc
	gpg --export --armor 968FBB1A > $(app)/files/mobile.asc
	gpg --export --armor 6A1CA097 > $(app)/files/debian.asc

static: $(standalone) $(cv) $(gpg)
	@touch  $(standalone) $(files) $(gpg)

clean-static:
	-rm  $(standalone) $(files) $(gpg)

.PHONY: clean-static
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

deploy: build
	-git submodule add $(gh_pages_repo) $(gh_pages_dir)
	git submodule update --init $(gh_pages_dir)

	cd $(gh_pages_dir) && git checkout master

	rsync -r $(dist)/ $(gh_pages_dir)/

	cd $(gh_pages_dir) && git add .
	cd $(gh_pages_dir) && git commit -am 'Makefile commit, rev $(revision)'
	cd $(gh_pages_dir) && git push

	-git commit -m'(auto) Update rev in submodule' $(gh_pages_dir)

.PHONY: deploy
####

clean: clean-static
	@-rm -rf $(www)/.sass-cache $(www)/.tmp $(dist)
	git clean -xdf $(www)
.PHONY: clean
