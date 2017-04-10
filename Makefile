### -*-Makefile-*- to setup package actuarialsymbol
##
## Copyright (C) 2017 Vincent Goulet
##
## 'make package' extracts the package file from the dtx file;
## 'make doc' compiles the documentation and glossary;
## 'make zip' creates an archive compliant with CTAN requirements;
## 'make all' does all of the above.
##
## Author: Vincent Goulet
##
## This file is part of project actuarialsymbol
## http://github.com/vigou3/actuarialsymbol

## Package name on CTAN
PACKAGENAME = actuarialsymbol

## Contents of the package (except README.md that is created by 'make
## zip')
FILES = actuarialsymbol.dtx actuarialsymbol.pdf

## Version number and release date extracted from dtx file. The result
## is a string of the form 'x.y (YYYY-MM-DD)'.
VERSION = $(shell awk -F '[ \[]' '/\ProvidesPackage/ \
	    { gsub(/\//, "-", $$2); \
	      printf("%s (%s)", substr($$3, 2), $$2); \
	      exit }' actuarialsymbol.dtx)

# Toolset
LATEX = pdflatex
MAKEINDEX = makeindex
RM = rm -r

all : pkg doc zip

pkg : actuarialsymbol.dtx
	${LATEX} $<

doc : actuarialsymbol.dtx actuarialsymbol.gls
	${LATEX} actuarialsymbol.dtx
	${MAKEINDEX} -s gglo.ist -o actuarialsymbol.gls actuarialsymbol.glo
	${LATEX} actuarialsymbol.dtx

zip : ${FILES}
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir ${PACKAGENAME}
	touch ${PACKAGENAME}/README.md && \
	  awk 'state==0 && /^# / { state=1 }; \
	       /^## Author/ { printf("## Version\n\n%s\n\n", "${VERSION}") } \
	       state' README.md >> ${PACKAGENAME}/README.md
	cp ${FILES} ${PACKAGENAME}
	zip --filesync -r ${PACKAGENAME}.zip ${PACKAGENAME}
	rm -r ${PACKAGENAME}
