#.SILENT:
all: deploy-lao deb-repo

build:
	blogofile 'build'
	rst2pdf _cv_pl.rst -co files/cv_pl.pdf -s _cv.style&
	rst2pdf _cv_en.rst -co files/cv_en.pdf -s _cv.style

serve:
	blogofile serve 8080

deploy-lao:
	echo "Deploying to laohost.net"
	echo "Changing site URL to essekkat.pl"
	sed -i 's|site.url = .*|site.url = "http://essekkat.pl"|' _config.py
	$(MAKE) build
	echo "SSH to laohost.net"
	rsync --delete-before --exclude 'debian/'  -rv _site/ lao:public_html/
	ssh lao 'chmod -R 755 public_html'
	echo "Deployed to laohost.net"

deploy-local:
	echo "Deploying to localhost/site"
	echo "Changing site URL to localhost/site"
	sed -i 's|site.url = .*|site.url = "http://localhost/site"|' _config.py
	make build
	rsync -r _site/ /var/www/html/site/
	chmod -R a+rX /var/www/html/site
	rsync -r _site/ /home/kamil/public_html/site/

deploy: deploy-lao deploy-local

deb-repo:
	rsync --delete-before -rv ~/public_html/debian/db/ lao:public_html/debian/db/
	rsync --delete-before -rv ~/public_html/debian/dists/ lao:public_html/debian/dists/
	rsync --delete-before -rv ~/public_html/debian/pool/ lao:public_html/debian/pool/

.PHONY: all
.PHONY: serve
.PHONY: tar
.SILENT: deploy-lao
