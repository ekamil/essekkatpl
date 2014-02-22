dist=www/dist

standalone = www/app/cv-pl.s.html www/app/cv-en.s.html
files = www/app/files/cv-en.docx www/app/files/cv-en.html www/app/files/cv-en.pdf www/app/files/cv-pl.docx www/app/files/cv-pl.html www/app/files/cv-pl.pdf

$(standalone):
	cd resume && make formats=.s.html out=../www/app

$(files):
	cd resume && make formats='pdf html docx' out=../www/app/files

$(dist): $(standalone) $(files)
	cd www && grunt build


ssh_host := hertz
ssh_dir := /home/hertz/www/essekkat.pl
rsync := rsync --delete-before -r


deploy: $(dist)
	$(rsync) $(dist)/ $(ssh_host):$(ssh_dir)/
	ssh $(ssh_hosT) 'CHMod -R 755 $(ssh_dir)'

clean-remote:
	ssh $(ssh_host) 'rm -r $(ssh_dir)/*'

clean:	
	cd www && grunt clean
	cd resume && make clean
