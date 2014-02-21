sources := cv-pl.rst cv-en.rst
formats = pdf html latex docx
out := build

PDF_OPT  = --compressed
PDF_OPT += --stylesheets=resources/cv.style
PDF_OPT += --strip-elements-with-class=visible-screen
PDF_OPT += --font-path=resources/fonts
pandoc = pandoc --from rst --to

pdf = rst2pdf $(PDF_OPT)
html = $(pandoc) html5 --email-obfuscation=none
latex = $(pandoc) latex
docx = $(pandoc) docx


RESULT = $(foreach f, $(formats), $(sources:.rst=.$(f) ) )

all: $(out) $(RESULT)

$(sources:.rst=.pdf): $(sources)
	$(pdf)  $< --output=$(out)/$@

$(sources:.rst=.html): $(sources)
	$(html) $< -o $(out)/$@

$(sources:.rst=.latex): $(sources)
	$(latex) $< -o $(out)/$@

$(sources:.rst=.docx): $(sources)
	$(docx) $< -o $(out)/$@


$(out):
	-mkdir $(out)
	touch $(out)

clean:	
	@-rm  -f $(out)/*
