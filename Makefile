CV_LIST := pl
OUT := build

PDF_OPT  = --compressed
PDF_OPT += --stylesheets=resources/cv.style
PDF_OPT += --strip-elements-with-class=visible-screen
PDF_OPT += --font-path=resources/fonts

pdf = rst2pdf $(PDF_OPT)
html = pandoc --from rst --to html5 --email-obfuscation=none
latex = pandoc --from rst --to latex
docx = pandoc --from rst --to docx

all: clean cv

cv: $(CV_LIST)

$(CV_LIST): $(OUT)
	$(pdf)  cv_$@.rst --output=$(OUT)/cv_$@.pdf
	$(html) cv_$@.rst -o $(OUT)/cv_$@.html 
	$(latex) cv_$@.rst -o $(OUT)/cv_$@.latex
	$(docx) cv_$@.rst -o $(OUT)/cv_$@.docx

$(OUT):
	-mkdir $(OUT)
	touch $(OUT)

clean:	
	@-rm  -rf $(OUT)
