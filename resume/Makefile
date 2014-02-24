sources := cv-pl.rst cv-en.rst
formats = pdf html latex docx s.html
out := $(PWD)

PDF_OPT  = --compressed
PDF_OPT += --stylesheets=resources/cv.style
PDF_OPT += --font-path=resources/fonts
pandoc = pandoc --from rst --to

pdf = rst2pdf $(PDF_OPT)
html = $(pandoc) html5 --email-obfuscation=references
htmls = $(html) --template=resources/default.html5 --standalone
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

.SUFFIXES: .rst $(foreach f, $(formats), .$(f) )

$(out):
	-mkdir $(out)

clean:	
	@-rm  -f $(foreach r, $(RESULT), $(out)/$(r) )

.PHONY: clean
