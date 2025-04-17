#
# Makefile for thesis generation using the Technion IIT document class
#
# To use it, you must have GNU Make installed (in addition to a LaTeX
# distribution), and standard shell tools like GNU `find`. Then, in the same
# directory as this file, invoke `make`.
#
# You can also invoke `make pvc` to "preview continuously" (i.e. pdf will update
# in real time while editing the source files), or `make clean` to remove all
# generated files.
#
# This is roughly based on:
# https://drewsilcock.co.uk/using-make-and-latexmk
# http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
#
# See also the various settings in .latexmkrc
#
AUXDIR=aux

LATEXMK=latexmk
CONTINUOUS=-pvc

MAIN=thesis
OUTPUT_FILENAME=thesis
SOURCES := Makefile $(shell find . -regex '.*\.\(tex\|cls\|sty\|bib\)')
ADDITIONAL_FILES := README.md
FIGURES := $(shell find graphics/* -type f)

all: symlink once

once: symlink
	$(LATEXMK) $(MAIN)

.refresh:
	touch .refresh

pvc: aux $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
	$(LATEXMK) $(CONTINUOUS) $(MAIN)

# Create a symlink for the final PDF
symlink: aux
	rm -f $(OUTPUT_FILENAME).pdf
	ln -Fs $(AUXDIR)/$(MAIN).pdf $(OUTPUT_FILENAME).pdf

clean:
	$(LATEXMK) -C $(MAIN) -quiet
	$(shell echo "find . -name '*.aux' -print0 | xargs -0 rm -f")
	$(shell find . -name '*.aux' -print0 | xargs -0 rm -f)
	rm -rf aux/
	rm -f .refresh
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.glo *.gls *.ist *.not *.ntn *.nlg *.glg
	rm -f *.bbl *.blg *.end *.fls *.log *.out *.fdb_latexmk *.cb *.thm
# not removing the biber cache - it's not guaranteed that biber is even available,
# or that biber --cache gives something meaningful

aux:
	mkdir -p aux aux/front aux/back aux/misc aux/main

$(MAIN).zip: $(SOURCES) $(FIGURES) $(ADDITIONAL_FILES)
	rm -f $(MAIN).zip
	zip $(MAIN).zip $(SOURCES) $(FIGURES) $(ADDITIONAL_FILES)

archive: $(MAIN).zip
zip: $(MAIN).zip


.PHONY: clean once symlink all aux
