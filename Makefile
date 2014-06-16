# configuration
ENV=
ssh_host := hertz
ssh_dir := /home/$(ssh_host)/www/$(ENV)essekkat.pl
langs = pl en
formats = pdf docx html latex

##### variables
www=$(PWD)/www
dist=$(PWD)/www/dist
app=$(PWD)/www/app

standalone = $(foreach l, $(langs), $(app)/cv-$(l).s.html)
files = $(foreach f, $(formats), $(foreach l, $(langs), $(app)/files/cv-$(l).$(f) ) )
gpg = $(app)/files/kamil_e.asc $(app)/files/debian.asc

rsync := rsync --delete-before -r

## default target
default: deploy

#### generate static files
$(standalone):
	cd resume && make formats=s.html out=$(app)

$(files):
	cd resume && make formats='$(formats)' out=$(app)/files

$(gpg):
	gpg --export --armor 598C2A2D > $(app)/files/kamil_e.asc 
	gpg --export --armor 90EB7B11 > $(app)/files/debian.asc 

static: $(standalone) $(files) $(gpg)
	@touch $(standalone) $(files) $(gpg)

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

## deployment
deploy: $(dist)
	$(rsync) $(dist)/ $(ssh_host):$(ssh_dir)/
	ssh $(ssh_host) 'chmod -R 755 $(ssh_dir)'

clean-remote:
	ssh $(ssh_host) 'rm -r $(ssh_dir)/*'

.PHONY: deploy clean-remote
####
clean:
	@-rm -rf $(www)/.sass-cache $(www)/.tmp $(dist)
	git clean -xdf $(www)
.PHONY: clean
