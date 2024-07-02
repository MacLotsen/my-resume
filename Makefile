TITLE ?= Resume - Erik Nijenhuis
AUTHOR ?= Erik Nijenhuis
ORG ?= Xerdi
COPYRIGHT ?= Copyright © 2024 \"$(AUTHOR)\"
CONTACT ?= Unknown
SUBJECT ?= Curriculum Vitae $(AUTHOR) - $(CONTACT)


.PHONY: example.pdf

draft: example.xmpdata
	latexmk --pvc --lualatex --jobname=example --interaction=nonstopmode resume
	latexmk -c example

%.xmpdata: resume.tex keywords.sh
	echo "\
	\Title{$(TITLE)}\n\
	\Author{$(AUTHOR)}\n\
	\Org{$(ORG)}\n\
	\Copyright{$(COPYRIGHT)}\n\
	\Subject{$(SUBJECT)}\n\
	\Keywords{$$(bash keywords.sh resume.tex)}" > $@

example.pdf: example.xmpdata my-resume.cls resume.tex picture.jpg
	lualatex --jobname example resume
	latexmk -c example.aux

screenshots: example.pdf
	convert example.pdf resume.png
