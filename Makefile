## Nom du paquetage sur CTAN
PACKAGENAME = actuarialsymbol

## Liste des fichiers à inclure dans l'archive (outre README)
FILES=actuarialsymbol.ins actuarialsymbol.dtx actuarialsymbol.pdf

## Numéro de version extrait du fichier actuarialsymbol.dtx
VERSION = $(shell awk -F '[ \[]' '/\\ProvidesPackage/ \
	    { gsub(/\//, "-", $$2); \
	      printf("%s (%s)", substr($$3, 2), $$2); \
	      exit }' actuarialsymbol.dtx)

# Outils de travail
LATEX = pdflatex
MAKEINDEX = makeindex
RM = rm -r

all : pkg doc zip

pkg : actuarialsymbol.dtx
	latex actuarialsymbol.ins

doc : actuarialsymbol.dtx actuarialsymbol.gls
	${LATEX} actuarialsymbol.dtx
	${MAKEINDEX} -s gglo.ist -o actuarialsymbol.gls actuarialsymbol.glo
	${LATEX} actuarialsymbol.dtx

zip : ${FILES}
	if [ -d ${PACKAGENAME} ]; then ${RM} ${PACKAGENAME}; fi
	mkdir ${PACKAGENAME}
	cp ${FILES} ${PACKAGENAME}
	sed -e 's/<VERSION>/${VERSION}/g' README.in > ${PACKAGENAME}/README
	zip --filesync -r ${PACKAGENAME}.zip ${PACKAGENAME}
	rm -r ${PACKAGENAME}
