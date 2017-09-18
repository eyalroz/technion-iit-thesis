The files in this archive constitute a template for a thesis (M.Sc. or Ph.D.) at the Technion, IIT.


## How do I get started using this template?

First, compile it.  The template should compile well on a modern (2013 or later) TeX distribution such as TeXLive or MikTeX. The most convenient way to do so is to use the `latexmk` Make-like tool included in these packages, in the template's root folder (where thesis.tex is), as follows:

    latexmk -pdf thesis

The build tool should invoke the appropriate executable repeatedly (including bibtex, pdfelatex etc.) until building has concluded or an error is encountered. The template, as distributed, compiles without error; and once you've compiled it you have a thesis.pdf file, which you should read for additional information

### Caveat: Hebrew support

One important hitch which you might encounter when building the template regards your TeX distribution's support for Hebrew, and the availability of the appropriate Hebrew fonts. TeX distributions don't currently install full support for Hebrew, and it may need to be augmented. What's more, there's more than one kind of Hebrew fonts in LaTeX --- MetaFont-based TeX-specific fonts, or use of more general-purpose TrueType/OpenType fonts installed on your system. At the moment, this template relies on the former rather than the latter; and these are not always / not ever even available as packages (it depends on the TeX distribution) - making things rather flakey. See the instructions on how to ensure the appropriate kind of Hebrew support / Hebrew font files are installed, here:

    http://tex.stackexchange.com/a/113385/5640  

or a more automated alternative, here:

    https://tex.stackexchange.com/a/149992/5640

## "Ok, I've compiled the template; what next?"

You modify it until it becomes your own actual thesis:

* Replace meta-data / general information in `misc/thesis-fields.tex` with your own details: Author name (you're the author), advisor/supervisor name, thesis title etc.
* Entirely delete some files (e.g. sample chapters you won't be using, and graphics files they use)
* Add files of your own (chapters, graphics, bibliographies etc.)

This is just a LaTeX document after all - there's no "magic" here beyond that.

## Directory and file layout

To understand the directory structure here, think about a printed book: It can be divided into three parts: Front matter, main matter, back matter. (But this gets a bit confused when you have a Hebrew version of the front matter at the end of your thesis submission... ) This implies the following structure:

thesis.tex
	The main file which you compile and includes/uses everything else
	(it has some additional comments and explanations)
front/
	abstract.tex	Thesis abstract (and extended Hebrew version of it)
	personal-acks.tex	Personal acknowledgements
	abbrevs.tex	Abbreviations and notation
	pubinfo.bib	mini-bibliography for listing venues in which the thesis work was published
main/
	*.tex Main chapters of your thesis:
	(possible) Introduction
	(possible) Preliminaries/Experimental setup
	Chapters with actual results
	(possible) Summary/conlcusions
	(possible) Open questions
back/
	*.bib	Bibliographies
graphics/
	*.pdf	
	*.png
	*.eps	...better use cropped PDFs instead
misc/
	thesis-fields.tex	A file setting the thesis author, subject, etc.
	LaTeX resources you need for compiling your thesis:
	iitthesis.cls	The document class 
	iitthesis-extra.sty	An additional useful "style file" you are advised to use; it is not necessary for compiling your thesis with the document class
	LaTeX resources you might add:
	my-general.tex	Your own general-purpose LaTeX macros/definitions
	my-thesis-specific.tex	Your own macros/definitions specific to just the thesis
README.txt	
	this file
README.md	
	GitHub repository header
makezip.sh
makezip.bat
	Used to create a ZIP archive of the template

## Problems / questions / suggestions?

If you're having trouble building the template; if you think it's missing something; or if you have another suggestion, visit the template's issues page at  

    https://github.com/eyalroz/technion-iit-thesis/issues

or write me: Eyal Rozenberg <eyalroz@technion.ac.il>

