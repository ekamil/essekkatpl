sources := cv-pl.rst cv-en.rst
formats = pdf html latex docx s.html
out := build

PDF_OPT  = --compressed
PDF_OPT += --stylesheets=resources/cv.style
PDF_OPT += --font-path=resources/fonts
pandoc = pandoc --from rst --to

pdf = rst2pdf $(PDF_OPT)
html = $(pandoc) html5 --email-obfuscation=none
htmls = $(pandoc) html5 --email-obfuscation=none --template=resources/default.html5 --standalone
latex = $(pandoc) latex
docx = $(pandoc) docx


RESULT = $(foreach f, $(formats), $(sources:.rst=.$(f) ) )

all: $(out) $(RESULT)

.rst.pdf:
	$(pdf)  $< --output=$(out)/$@

.rst.html:
	$(html) $< -o $(out)/$@

.rst.s.html:
	$(htmls) -V $(basename $<) $< -o $(out)/$@

.rst.latex:
	$(latex) $< -o $(out)/$@

.rst.docx:
	$(docx) $< -o $(out)/$@


$(out):
	-mkdir $(out)
	touch $(out)

clean:	
	@-rm  -f $(out)/*


.SUFFIXES: .rst $(foreach f, $(formats), .$(f) )
