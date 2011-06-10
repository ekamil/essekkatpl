#.SILENT:
all:
	make clean-remotes
	make deploy_lao
	make deploy_akson

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
	ssh akson 'rm -rf WWW/*'
	echo "Clean 000webhost manually"

deploy_lao:
	echo "Deploying to laohost.net"
	echo "Changing site URL to essekkat.pl"
	sed -i 's|site.url = .*|site.url = "http://essekkat.pl"|' _config.py
	echo "SSH to laohost.net"
	rsync -av _site/ lao:public_html/
	ssh lao 'chmod -R 755 public_html'
	echo "Deployed to laohost.net"

deploy_akson:
	echo "Deploying to akson.sgh.waw.pl"
	echo "Changing site URL to akson.sgh.waw.pl/~ke48003"
	sed -i 's|site.url = .*|site.url = "http://akson.sgh.waw.pl/~ke48003"|' _config.py
	echo "SSH to akson.sgh.waw.pl"
	rsync -av _site/ akson:WWW/
	ssh akson 'fixWWWperm'
	echo "Deployed to akson"

deploy_local:
	echo "Deploying to localhost/site"
	echo "Changing site URL to localhost/site"
	sed -i 's|site.url = .*|site.url = "http://localhost/site"|' _config.py
	rsync -av _site/ ~/WWW/site/

deploy:
	make deploy_lao
	make deploy_akson

.PHONY: all
.PHONY: serve
.PHONY: tar
.SILENT: deploy_lao
.SILENT: deploy_akson
