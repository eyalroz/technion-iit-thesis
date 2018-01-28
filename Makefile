# Makefile for thesis.
# Simply run `make` to build the thesis.pdf.
# You can also use `make pvc` to "preview continuously" (i.e. pdf will update
# in real time while editing the source files).
# Use `make clean` to remove all generated files.
# Note that all auxilliary files will be stored in the `aux` directory to keep
# the root directory clean.
#
# This is roughly based on: 
# https://drewsilcock.co.uk/using-make-and-latexmk
# http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
#

LATEX=xelatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode
AUXDIR=aux

LATEXMK=latexmk
LATEXMKOPT=-pdf -outdir=$(AUXDIR) -auxdir=$(AUXDIR)
CONTINUOUS=-pvc

MAIN=thesis
OUTPUT_FILENAME=thesis
SOURCES := Makefile $(shell find . -name '*.tex')
FIGURES := $(shell find graphics/* -type f)

all: symlink once

once: symlink
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

.refresh:
	touch .refresh

pvc: aux $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) -pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

# Create a symlink for the final PDF
symlink: aux
	rm $(OUTPUT_FILENAME).pdf
	ln -Fs $(AUXDIR)/$(MAIN).pdf $(OUTPUT_FILENAME).pdf

clean:
	$(LATEXMK) -C $(MAIN)
	rm -rf aux
	rm -f .refresh
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk
	rm -rf `biber --cache`

aux:
	mkdir -p aux aux/front aux/back aux/misc aux/main

.PHONY: clean once symlink all aux
