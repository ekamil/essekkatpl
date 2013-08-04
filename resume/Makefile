CV_LIST   = pl en
OUT = build

PDF_OPT  = --compressed
PDF_OPT += --stylesheets=resources/cv.style
PDF_OPT += --strip-elements-with-class=screen-only
PDF_OPT += --font-path=resources/fonts
PDF = rst2pdf $(PDF_OPT)

HTML_OPT = --config=rst2html.config

uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
ifeq ($(uname_S), Linux)
HTML = rst2html $(HTML_OPT)
else
HTML = python /Python27/Scripts/rst2html.py $(HTML_OPT)
endif

TEX = rst2latex $(HTML_OPT)

all: clean cv

cv: $(CV_LIST)

$(CV_LIST): $(OUT)
	$(PDF)  cv_$@.rst --output=$(OUT)/cv_$@.pdf
	$(HTML) cv_$@.rst $(OUT)/cv_$@.html 

$(OUT):
	-mkdir $(OUT)
	touch $(OUT)

clean:	
	@-rm  -rf $(OUT)
