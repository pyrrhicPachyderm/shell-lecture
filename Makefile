SHELL := /bin/bash
LATEXMK_FLAGS = --pdf --cd
maindoc := slides
RM := rm -f


all: $(maindoc).pdf

$(maindoc).pdf: $(maindoc).tex
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
Clean: clean
	@$(RM) $(maindoc).pdf
clear:
	clear
	clear

.PHONY: all pvc clean Clean clear
