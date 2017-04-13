### -*-Makefile-*- to setup package actuarialsymbol
##
## Copyright (C) 2017 Vincent Goulet
##
## 'make pkg' extracts the package file from the dtx file;
## 'make doc' compiles the documentation and glossary;
## 'make zip' creates an archive compliant with CTAN requirements;
## 'make all' does all of the above.
##
## In addition, 'make list' creates the spin-off comprehensive life
## contingencies symbols list.
##
## Author: Vincent Goulet
##
## This file is part of project actuarialsymbol
## http://github.com/vigou3/actuarialsymbol

## Package name on CTAN
PACKAGENAME = actuarialsymbol

## Contents of the package (except README.md that is created by 'make
## zip')
FILES = ${SOURCE} ${DOC} ${AUXFILES}
SOURCE = ${PACKAGENAME}.dtx
DOC = ${PACKAGENAME}.pdf
AUXFILES = mosaic.jpg

## Symbol list kep in a separate file
LIST = symbols.tex

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

pkg : ${SOURCE}
	${LATEX} $<

doc : ${SOURCE} ${PACKAGENAME}.gls ${LIST}
	${LATEX} $<
	${MAKEINDEX} -s gglo.ist -o ${PACKAGENAME}.gls ${PACKAGENAME}.glo
	${LATEX} $<

## The symbol list is kept in a separate file and \input in the dtx
## file. To ease distribution on CTAN, we merge the two files below.
zip : ${FILES}
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir ${PACKAGENAME}
	touch ${PACKAGENAME}/README.md && \
	  awk 'state==0 && /^# / { state=1 }; \
	       /^## Author/ { printf("## Version\n\n%s\n\n", "${VERSION}") } \
	       state' README.md >> ${PACKAGENAME}/README.md
	awk -F '[{}]' '{ if ($$1 == "% \\input"){ \
			     file = ($$2".tex"); \
			     while ((getline line < file) > 0) print ("% "line); \
			     close(file)} \
			 else \
			     print }' ${SOURCE} > ${PACKAGENAME}/${SOURCE}
	cp ${DOC} ${AUXFILES} ${PACKAGENAME}
#	zip --filesync -r ${PACKAGENAME}.zip ${PACKAGENAME}
#	rm -r ${PACKAGENAME}

list : ${PACKAGENAME}-list.tex ${LIST}
	${LATEX} $<
