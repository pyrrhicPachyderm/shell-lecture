SHELL := /bin/bash
LATEXMK_FLAGS = --pdf --cd
maindoc := slides
RM := rm -f

slides_images := images/substitutions.png

all: $(maindoc).pdf

$(maindoc).pdf: $(maindoc).tex $(slides_images)
	latexmk $(LATEXMK_FLAGS) --jobname="$(basename $@)" $<
pvc: $(maindoc).pdf
	latexmk $(LATEXMK_FLAGS) --jobname="$(basename $<)" $< --pvc
clean:
	@latexmk $(LATEXMK_FLAGS) -c -silent
	@(\
		shopt -s globstar;\
		$(RM) **/*.aux **/*.fls **/*.fdb_latexmk;\
		$(RM) **/*.bbl **/*.run.xml **/*.auxlock;\
		$(RM) **/*.dep **/*.dpth **/*.log **/*.md5 **/*-figure*.pdf;\
	)
	@(\
		shopt -s globstar;\
		$(RM) $(slides_images);\
	)
Clean: clean
	@$(RM) $(maindoc).pdf
clear:
	clear
	clear


images/substitutions.png:
	wget https://imgs.xkcd.com/comics/substitutions.png -O $@

.PHONY: all pvc clean Clean clear
