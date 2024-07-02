
.PHONY: example.pdf

draft:
	latexmk --pvc --lualatex --jobname=example --interaction=nonstopmode resume
	latexmk -c example

example.pdf: my-resume.cls resume.tex picture.jpg
	lualatex --jobname example resume
	latexmk -c example

screenshots: example.pdf
	convert example.pdf resume.png
