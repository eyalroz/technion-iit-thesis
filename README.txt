The files in this archive constitute a sample template for a thesis (M.Sc. or Ph.D.) at the Technion, IIT.

This should compile well on a modern TeX distro such as MiKTeX or TeX Live. Packages which should specifically be up-to-date (e.g. early 2012) for using the class are: etoolbox, babel and atbegshi. 

Most of them you would replace with your files (or replace their content with what's relevant to your thesis); some you would need to keep.

To understand the directory structure here, think about a printed book: It can be divided into three parts: Front matter, main matter, back matter. (But this gets a bit confused when you have a Hebrew version of the front matter at the end of your thesis submission... )

Thus the directory structure is:

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
	*png
	*.eps	...better use cropped PDFs instead
misc/
	thesis-fields.tex	A file setting the thesis author, subject, etc.
	LaTeX resources you need for compiling thesis:
	iitthesis.cls	The document class 
	iitthesis-extra.sty	An additional useful "style file" you are advised to use; it is not necessary for compiling your thesis with the document class
	LaTeX resources you might add:
	my-general.tex	Your own general-purpose LaTeX macros/definitions
	my-thesis-specific.tex	Your own macros/definitions specific to just the thesis
README.txt	
	This file
makezip.sh
makezip.bat
	Used to create a ZIP archive of the template
