# technion-iit-thesis

A LaTeX document class for authoring masters' or doctoral thesis at the Technion IIT, in conformance with the Technion's formatting requirements, and a sample thesis using this LaTeX class, the files and directory structure of which can serve as a template for a real thesis.

## Using the template

### Getting started

Basically, you just compile it using `xelatex`. The template should compile well on a modern (2013 or later) TeX distribution such as TeXLive or MikTeX. The most convenient way to do so is to use the `latexmk` Make-like tool included in these packages, in the template's root folder (where `thesis.tex` is located), as follows:

    latexmk -xelatex thesis

The build tool should invoke the appropriate executable repeatedly (including `bibtex`, `xelatex` etc.) until building has concluded or an error is encountered. The template, as distributed, should compile without error (but with some warnings); once you've compiled it you have a `thesis.pdf` file, which you should read for additional information.

Alternatively, if you're on a Unix-like system, you can use the Makefile; see [this description](https://github.com/eyalroz/technion-iit-thesis/pull/19). If you don't know what a Makefile is - never mind.

### "Ok, I've compiled the template; what next?"

You modify it until it becomes your own actual thesis:

* Replace meta-data / general information in `misc/thesis-fields.tex` with your own details: Author name (you're the author), advisor/supervisor name, thesis title etc.
* Entirely delete some files (e.g. sample chapters you won't be using, and graphics files they use)
* Add files of your own (chapters, graphics, bibliographies etc.)

### Caveat: Hebrew support

Your TeX distribution must include the appropriate packages for supporting the use of Hebrew in (Xe)LaTeX. Specifically, the Culmus fonts should be available, as one of them (David CLM) is used by default. In past versions, the template relied on the `babel` package and the `Jerusalem` and other old-style fonts; this is no longer the case: the [`polyglossia`](http://ctan.org/pkg/polyglossia) and the  [`bidi`](http://ctan.org/pkg/bidi) packages are now in use. Still, Hebrew is tricky and some packages have either compatibility issues with `polyglossia`/`bidi`, or must be loaded before `bidi`.

### Overleaf support
As of early 2022, this template works seamlessly with Overleaf --- if you set the compiler to XeLaTeX version 2018.
To do so, first clone the (up-to-date) Overleaf template, then click the Menu button on the top left corner and select XeLaTeX as the compiler and 2018 as the Tex Live version.


## About this project

### GitHub repository

If you've found this file within some archive or on one of the Technion's web server, note that the thesis template is maintained as a [GitHub repository](https://github.com/eyalroz/technion-iit-thesis/). Always go there for the latest version.

### Key Features

- (Hopefully) maintained to be in conformance with the [Technion graduate school](http://www.graduate.technion.ac.il/eng)'s [requirements from Ph.D. theses](http://www.graduate.technion.ac.il/eng/FinalProcedures/Editing%20%20Submission%20of%20Thesis.htm) ([Hebrew version](http://www.graduate.technion.ac.il/Heb/Graduation/Thesis_editing.asp)).
- Supports printing _everything_ just once, into a single PDF file, in a single run, with all of the spacing arranged properly. This may sound trivial if you don't write in Hebrew, but it is a small hell to get this all to work without having to insert empty pages in your LaTeX, print sections separately, flip directions of the printed versions etc. No more!
- Has both a pre-thesis-defense mode, for the version sent to your thesis readers, and a post-defense mode for the copies you submit to the library, give to your friends/wife/parents/children etc.
- Various convenience features (most of them outside of the document class file and in an optional `.sty` style file)

### Is this actually used or endorsed?

This class was adopted as the [official Ph.D. thesis template]((https://graduate.cs.technion.ac.il/en/graduate-studies/graduation/hagasha/) of the [Technion Faculty of Computer Science](http://www.cs.technion.ac.il/), in 2013. Numerous Ph.D. and M.Sc. candidates have used it already, but we don't have any statistics.

### Contributors

* **Current maintainer**: [Eyal Rozenberg](mailto:eyalroz1@gmx.com)
* **Original author**: Dan Kenigsberg
* **Contributor**: [Ido Tal](mailto:idotal@ee.technion.ac.il)


## Got a question, suggestions or other kind of feedback?

| **If you have...**                                               | **then you should...**                                                                                                                                                                                                            |
|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| question about using the thesis template                         | write [the maintainer](mailto:eyalroz1@gmx.com)                                                                                                                                                                             |
| bug / mistake you'd like to report                               | file it as a new issue on the [issues page](https://github.com/eyalroz/technion-iit-thesis/issues)                                                                                                                                |
| suggestion or feature request regarding the template             | file it as a new issue on the [issues page](https://github.com/eyalroz/technion-iit-thesis/issues)                                                                                                                                |
| question regarding the thesis submission process                     | Contact your department's graduate studies secretariat.                                                          |
| question regarding the Graduate School's guidelines for theses | Contact the "conclusion-stage" department at the Graduate School (Contact info: [English](http://www.graduate.technion.ac.il/Eng/General_info/Contact_us.asp), [Hebrew](http://www.graduate.technion.ac.il/Heb/General/Contact_us.asp)) |
| the ability to help the maintainer get his `@technion.ac.il` email address back | write [the maintainer](mailto:eyalroz1@gmx.com)                                                                                                                                                                             |
| some other kind of feedback                                      | write [the maintainer](mailto:eyalroz1@gmx.com)                                                                                                                                                                             |

## Directory and file layout

To understand the directory structure here, think about a printed book: It can be divided into three parts: Front matter, main matter, back matter. (But this gets a bit confused when you have a Hebrew version of the front matter at the end of your thesis submission... ) This division induces the following structure:

```
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
README.md	
	this file
Makefile
        Does some build/cleaning automation for you
makezip.sh
makezip.bat
	Used to create a ZIP archive of the template
```
