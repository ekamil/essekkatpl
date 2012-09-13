#.SILENT:
all:
	make clean-remotes
	make deploy_lao

build:
	blogofile 'build'
	rst2pdf _cv_pl.rst -co files/cv_pl.pdf -s _cv.style&
	rst2pdf _cv_en.rst -co files/cv_en.pdf -s _cv.style

serve:
	blogofile serve 8080

tar:
	make build
	tar -czf `pwd`/site.tar.gz -C _site/ .

clean-remotes:
	ssh lao 'rm -rf public_html/*'

deploy_lao:
	echo "Deploying to laohost.net"
	echo "Changing site URL to essekkat.pl"
	sed -i 's|site.url = .*|site.url = "http://essekkat.pl"|' _config.py
	make build
	echo "SSH to laohost.net"
	rsync -av _site/ lao:public_html/
	ssh lao 'chmod -R 755 public_html'
	echo "Deployed to laohost.net"

deploy_local:
	echo "Deploying to localhost/site"
	echo "Changing site URL to localhost/site"
	sed -i 's|site.url = .*|site.url = "http://localhost/site"|' _config.py
	make build
	rsync -r _site/ /var/www/html/site/
	chmod -R a+rX /var/www/html/site
	rsync -r _site/ /home/kamil/public_html/site/

deploy:
	make deploy_lao
	make deploy_local

.PHONY: all
.PHONY: serve
.PHONY: tar
.SILENT: deploy_lao
