CV_LIST   = pl en
CONFIG    = resources/rst2html.config
OUT = build

PDF_OPT = --compressed --stylesheets=resources/cv.style
PDF = rst2pdf $(PDF_OPT)

RST_OPT = --config=$(CONFIG)
HTML = rst2html $(RST_OPT)
TEX = rst2latex $(RST_OPT)

cv: $(CV_LIST)

$(CV_LIST): $(OUT)
	$(PDF)  cv_$@.rst --output=$(OUT)/cv_$@.pdf
	$(HTML) cv_$@.rst $(OUT)/cv_$@.html 
	$(TEX)  cv_$@.rst $(OUT)/cv_$@.tex 

$(OUT):
	-mkdir $(OUT)
	touch $(OUT)

clean:	
	@-rm  -rf $(OUT)