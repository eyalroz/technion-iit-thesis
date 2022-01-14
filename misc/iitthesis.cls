%%
%% iitthesis
%%
%% A class for authoring graduate degree theses
%% according to the specifications of the Technion -
%% Israeli Institute of Technology
%%
%% GitHub repository:
%% https://github.com/eyalroz/technion-iit-thesis/
%%
%%
%% Maintainer:
%% Eyal Rozenberg       <eyalroz@technion.ac.il>
%%                      <eyalroz@riseup.net>
%%
%% Original author:
%% Dan Kenigsberg       <danken@cs.technion.ac.il>
%%
%% Contributor:
%% Ido Tal              <idotal@ee.technion.ac.il>
%%
%%

\def\filename{iitthesis}
\def\fileversion{v0.9}
\def\filedate{2017/09/18}
\NeedsTeXFormat{LaTeX2e}
\edef\iitthesis@TechnionIITThesis{%
\filedate\space\fileversion\space - Technion IIT Thesis}
\ProvidesClass{\filename}[\iitthesis@TechnionIITThesis]

%--------------------------------

% Packages and package option setting - before option processing

\RequirePackage{etoolbox}

%--------------------------------

% The different degrees the Technion awards for which you might
% be writing a thesis. At the moment, the author(s) are not aware of
% any difference in the style requirements for theses for
% different degrees

% A Ph.D. thesis is the default...
\newcommand{\iitthesis@degreeEnglish}{Doctor of Philosophy}
\newcommand{\iitthesis@degreeHebrew}{דוקטור לפילוסופיה}
\DeclareOption{PhD}{%
}

\DeclareOption{MSc}{%
  \renewcommand{\iitthesis@degreeEnglish}{Master of Science in \iitthesis@disciplineEnglish}
  \renewcommand{\iitthesis@degreeHebrew}{מגיסטר למדעים ב\relax\iitthesis@disciplineHebrew}
}

\DeclareOption{MArch}{%
  \renewcommand{\iitthesis@degreeEnglish}{Master of Architecture}
  \renewcommand{\iitthesis@degreeHebrew}{מגיסטר לארכיטקטורה}
}

\DeclareOption{MEcon}{%
  \renewcommand{\iitthesis@degreeEnglish}{Master of Economics}
  \renewcommand{\iitthesis@degreeHebrew}{מגיסטר לכלכלה}
}

\DeclareOption{ME}{%
  \renewcommand{\iitthesis@degreeEnglish}{Master of Engineering}
  \renewcommand{\iitthesis@degreeHebrew}{מגיסטר להנדסה}
}

\newbool{iitthesis-abbrevs}
\booltrue{iitthesis-abbrevs}
\DeclareOption{noabbrevs}{
  % No abbreviations & notiation section
  \boolfalse{iitthesis-abbrevs}
}

\newbool{iitthesis-includeack}
\booltrue{iitthesis-includeack}
\DeclareOption{beforeDefense}{
  % No personal Acknowledgement are printed before the thesis is successfully
  % defended (this is also known, especially in Hebrew, as taking an "exam on
  % your thesis")
  \boolfalse{iitthesis-includeack}
}

\newcommand{\iitthesis@geometry}{%
  \geometry{a4paper,nohead,twoside,top=2.5cm,bindingoffset=1.5cm,hmargin=2.5cm}}
\DeclareOption{fullpageDraft}{
 \newcommand{\iitthesis@fullpageDraft}{}
 \renewcommand{\iitthesis@geometry}{%
   \geometry{a4paper,nohead,twoside,bindingoffset=0cm,vmargin=2.5cm,hmargin=2.5cm}}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

\LoadClass[a4paper,11pt,twoside,openright]{report}

%--------------------------------

% Packages and package option setting - after option processing

% The following package  is required for fixing a Hebrew bulleted list issue, see
% https://tex.stackexchange.com/questions/53444/
\RequirePackage{enumitem}
\RequirePackage{fontspec}
\RequirePackage{geometry} % Note: must be loaded before bidi
\RequirePackage{setspace}
\RequirePackage{atbegshi}

\iitthesis@geometry

%--------------------------------

% Polyglossia & language settings

% Note: We're not indicating the use of Hebrew right away, because the 
% bidi package, which polyglossia loads for Hebrew text, is very picky 
% about when it can be loaded. It must be loaded _after_ packages such as
% graphics, amsmath, float, ntheorem and others; and since we're not 
% going to load all of these right away (in fact, we might not be loading 
% them at all - it's up to the document author whether s/he needs them or 
% not) we want to defer loading and using polyglossia until after the 
% document author has loaded whatever it is they intend to use

\RequirePackage{polyglossia}
\setmainlanguage{english} % Palestine was under British rule after all
\IfFileExists{bidi.sty}{}{\ClassError{\filename}{The bidi package is not available for loading}{}}
\AtEndPreamble{
 \setotherlanguage[numerals=arabic,calendar=gregorian]{hebrew}
 \newfontfamily\hebrewfont[Script=Hebrew]{David CLM}
 % These next two lines fix an issue with equation numbering parentheses;
 % see: https://tex.stackexchange.com/a/141437/5640
 \def\maketag@@@#1{\hbox{\m@th\normalfont\LRE{#1}}}
 \def\tagform@#1{\maketag@@@{(\ignorespaces#1\unskip)}}
}

%--------------------------------

%\doublespacing
\onehalfspacing

%--------------------------------


% A mechanism for determining whether the document contained
% any figures. Using this, we can decide whether or not we need
% a list of figures
% see: http://tex.stackexchange.com/q/33193/5640
%

\AtEndEnvironment{figure}{\gdef\iitthesis@havefigures{}}
% The following fails for some reason... moving it to the
% makebackmatter command
%\AtEndDocument{
% \ifdefined\iitthesis@havefigures
%  \label{iitthesis:had-figures}
% \fi
%}
\newcommand{\conditionallistoffigures}{
 \@ifundefined{r@iitthesis:had-figures}
 {}
 {%
  \listoffigures%
  \addcontentsline{cot}{chapter}{רשימת איורים}%
  \addcontentsline{toc}{chapter}{List of Figures}%
  }
}%

%--------------------------------

% Commands regarding the typesetting of the Hebrew material
% at the end of the thesis

% This commands flips the inner and outer margins; the motivation is
% that for Hebrew content, the binding is on the right side of the first
% page on the sheet, and on the left side of the second page on the sheet
% (not sure if I can call them recto and verso in this situation)
% see: http://tex.stackexchange.com/q/33193/5640
%
% The link also has code for when you have 'headings' page styles, which in
% general Technion theses should not

\newcommand*{\flipmargins}{%
  \clearpage
  \setlength{\@tempdima}{\oddsidemargin}%
  \setlength{\oddsidemargin}{\evensidemargin}%
  \setlength{\evensidemargin}{\@tempdima}%
  \if@reversemargin
    \normalmarginpar
  \else
    \reversemarginpar
  \fi
}

% see http://tex.stackexchange.com/q/21703/5640

\newif\ifRP%
\newbox\RPbox%
\setbox\RPbox\vbox{\vskip1pt}%
\AtBeginShipout{%
  \ifRP
    \AtBeginShipoutDiscard%
    \global\setbox\RPbox\vbox{\unvbox\RPbox
      \box\AtBeginShipoutBox\kern\c@page sp}%
  \fi
}%
\renewcommand{\RPtrue}{%
  \clearpage
  \ifRP\RPfalse\fi
  \global\let\ifRP\iftrue
}%
\let\reversepageorder=\RPtrue%
\renewcommand{\RPfalse}{%
  \clearpage
  \global\let\ifRP\iffalse
  \setbox\RPbox\vbox{\unvbox\RPbox
    \def\protect{\noexpand\protect\noexpand}%
    \@whilesw\ifdim0pt=\lastskip\fi
      {\c@page\lastkern\unkern\shipout\lastbox}%
  }%
}%
\let\resumenormalpageorder=\RPfalse%

%--------------------------------

% All the various data fields which the user must/should set, with
% generic/placeholder defaults
%
% for every thesis field, say titleEnglish, the class user (that means you
% who are writing your thesis) must invoke
% \titleEnglish{Non-linear Hummus Optimization}
% to replace the default;  every field has its own command, e.g. for the  name
% of your discipline in Hebrew you would use
% \disciplineHebrew{Bio-technical Engineering}
%
% Note that _all_ fields defined below are necessary, at the moment,
% to meet the Technion's thesis submission guidelines
%

%
\newcommand{\iitthesis@thesisdatafield}[2]{%
  % this defines the internal command which stores the field value
  \@namedef{iitthesis@#1}{#2}
  % this defines the command with which the class user will set the value
  \long\@namedef{#1}##1{\@namedef{iitthesis@#1}{##1}}
}

\iitthesis@thesisdatafield{authorEnglish}{Name of Author}
\iitthesis@thesisdatafield{authorHebrew}{שם המחבר}
\iitthesis@thesisdatafield{titleEnglish}{Thesis Title}
\iitthesis@thesisdatafield{titleHebrew}{כותרת החיבור}
\iitthesis@thesisdatafield{disciplineEnglish}{Discipline Name}
\iitthesis@thesisdatafield{disciplineHebrew}{שם התחום המדעי}
\iitthesis@thesisdatafield{supervisionEnglish}{Information regarding the supervision and supervisors}
\iitthesis@thesisdatafield{supervisionHebrew}{מידע על המנחים וההנחיה}
\iitthesis@thesisdatafield{publicationInfoHebrew}{ציון אם העבודה פורסמה בכתבי עת או  הוצגה בכנסים. הרשימה תכתב בהתאם לכללי הציטוט (כולל הכותר ושמות השותפים). במקרה של שיתוף פעולה, פירוט תרומת המגיש.}
\iitthesis@thesisdatafield{publicationInfoEnglish}{Info about whether the contents of the thesis was published, about collaborators and the thesis author's contribution.}
\iitthesis@thesisdatafield{GregorianDateEnglish}{Gregorian Month and Year}
\iitthesis@thesisdatafield{GregorianDateHebrew}{חודש ושנה גרגוריאניים}
\iitthesis@thesisdatafield{JewishDateEnglish}{Hebrew Month and Year}
\iitthesis@thesisdatafield{JewishDateHebrew}{חודש ושנה עבריים}
\iitthesis@thesisdatafield{personalAcknowledgementEnglish}{The author's personal acknowledgements.}
\iitthesis@thesisdatafield{personalAcknowledgementHebrew}{שלמי-התודה של המחבר.}
\iitthesis@thesisdatafield{financialAcknowledgementEnglish}{The generous financial help of the Technion is gratefully acknowledged.}
\iitthesis@thesisdatafield{financialAcknowledgementHebrew}{אני מודה לטכניון על התמיכה הכספית הנדיבה בהשתלמותי.}
% Regulations require the English abstract contain 200-500 words.
\iitthesis@thesisdatafield{abstractEnglish}{Abstract of the thesis.}
% Regulations require the Hebrew abstract contain 1,000-2,000 words.
\iitthesis@thesisdatafield{abstractHebrew}{תקציר החיבור.}
\iitthesis@thesisdatafield{thesisbibstyle}{alpha}
% the following should be a comma-separate list of relative filenames,
% e.g. {backmatter/compsci.bib,backmatter/math.bib,specific.bib}
\iitthesis@thesisdatafield{thesisbibfiles}{}

%--------------------------------

% These next two commands are for the class user to invoke:


\newcommand{\makefrontmatter}{%
 \makeatletter
 \hypersetup{pdftitle={\iitthesis@titleEnglish},pdfauthor={\iitthesis@authorEnglish}}
 \makeatother

 \pagestyle{empty}

 \makecoverEnglish
 \cleardoublepage
 \maketitleEnglish
 \cleardoublepage
 \makeacknowledgementsEnglish
 \cleardoublepage

 % Workaround: The first page of the table of contents is getting numbered,
 % although it's not supposed to be (pagestyle empty); so let's at least
 % change the numbering style so that we don't actually get the number...
 \emptypagenumbering
 \tableofcontents
 \cleardoublepage
 \conditionallistoffigures
 \cleardoublepage

 % Regulations require that numbering starts on the first page
 % of the abstract, being page 1
 \pagestyle{plain}
 \pagenumbering{arabic}
 \setcounter{page}{1}
 \makeabstractEnglish
 \cleardoublepage

 \ifbool{iitthesis-abbrevs}{
  \makeabbreviationsAndNotation
  \cleardoublepage
 }{ }
}

\newcommand{\makebibliography}{%
  \ifx\iitthesis@thesisbibfiles\@empty
    \PackageError{iitthesis}{%
      No bibliography files specified; a thesis must contain a bibliography.}
  \else
    \ifdefined\pdfbookmark
      % If hyperref is loaded, this will help us to more
      % easily navigate to the bibliography
      \pdfbookmark[0]{Bibliography}{bib}%
    \fi
    \bibliographystyle{\iitthesis@thesisbibstyle}%
    \bibliography{\iitthesis@thesisbibfiles}%
  \fi%
}

\newcommand{\makebackmatter}{%

 % This _should_ be done AtEndDocument, but that fails for some reason
 \ifdefined\iitthesis@havefigures
  \label{iitthesis:had-figures}
 \fi

 \clearpage
 \makebibliography

 % Note that the order of pages here will in fact be
 % the order of pages when opening the bound thesis from
 % the ``Hebrew side'', i.e. from the back cover of the English side
 % which is the front cover for the Hebrew side; thus
 % after printing, you have to take all the pages starting
 % from the Hebrew cover page, as a packet, and reverse their direction

 % We do not make the bibliography here - for now...

 \clearpage
 \pagestyle{empty}

 % We are now on the next page after the end of the main matter. We wish
 % to begin the Hebrew content - but we don't want to do this on the same
 % sheet, with English on the recto side and Hebrew on the verso; the Hebrew
 % content pages are added to the PDF in reverse direction and we wish to
 % begin 'cleanly' with the English sheets complete and left alone, so we
 % just clear the sheet
 \cleardoublepage

 \reversepageorder
   % reversing the output page order from this point on

 % The first Hebrew page must appear with the binding to its right; but the
 % way things are so far in the document is that odd pages (recto) have
 % margins to the left. So... maybe we should \cleartoleftpage (i.e. clear
 % to the next verso)? No, this will not to. Why? For two reasons.
 %
 % First, remember the page order is reversed. The last page we get on the
 % output, being the first page we set here, must be the Hebrew cover page,
 % not a blank page.
 %
 % Second, if we \cleartoleftpage, this will mess up the  page ordering.
 % If the Hebrew pages are:
 %
 % Title verso, Empty recto, IntroPage1 verso, IntroPage2 recto
 %
 % then a \cleartoleftpage would give us the following sheets:
 %
 % Empty recto + Title verso , Empty recto + IntroPage1 verso,
 % IntroPage2 recto + nothing/empty verso
 %
 % which is not what we wanted: We get a gratuitious empty page between
 % pages 1 and 2 of the intro... so we actually have no choice but to flip
 % the margins

 \flipmargins

 \makecoverHebrew
 % We're not clearing to a verso page, since we've flipped the margins;
 % this should generate 1 empty page between the cover page and the title page
 \cleardoublepage
 \maketitleHebrew
 \cleardoublepage
 \makeacknowledgementsHebrew
 \cleardoublepage

 \pagestyle{plain}
 % We need to reset the displayed page number, but we don't want to
 % change the "real" page number, specifically for verso/recto margin
 % setting reasons; see:
 % http://tex.stackexchange.com/q/36011/5640
 %
 \displayedpagenumbering{roman}{1}

 \makeabstractHebrew
 % For some reason, if you \clearpage after the Hebrew abstract, the
 % \AtEndDocument command which is part of the auto-list-of-figures
 % generation is not run; so commenting this out
 %\clearpage

 % Consider using the solution here:
 % http://tex.stackexchange.com/q/21703/5640
 %\usepackage{atbegshi}
 % and reverse the ordering of the Hebrew sheets

 \resumenormalpageorder
    % now outputting the reversed pages and resuming normal order
    % (although we have no pages left...)

 % The glossary only includes the terms used in the text body by default. Comment out this
 % line if you want this behavior. This has to be done at the end of the document
 % to prevent the glossary page list to have spurious commas.
 \glsaddallunused
}

%--------------------------------

% Commands which the class user should not directly invoke; they
% are used in \makefrontmatter and \makebackmatter
%

\newcommand{\makecoverEnglish}{%
% Front cover / cover page
 \begin{center}
  \pagestyle{empty}

  \vspace*{\stretch{1}}
  \begin{spacing}{1}
    \Huge \textbf{\iitthesis@titleEnglish}
  \end{spacing}
  \Large

  \vspace*{\stretch{1}}

  \vphantom{Research Thesis}

  \vspace*{\stretch{0.5}}

  \vphantom{\parbox{4in}{
    \normalsize
    \begin{center}
      Submitted in partial fulfillment of the requirements \\
      for the degree of \iitthesis@degreeEnglish
    \end{center}
  }}


  \vspace*{\stretch{2}}

  {\LARGE \textbf{\iitthesis@authorEnglish}}

  \vspace*{\stretch{3}}

  \vphantom{\parbox{3.5in}{
    \normalsize
    \begin{center}
      Submitted to the Senate \\
      of the Technion {\textemdash} Israel Institute of Technology
      \iitthesis@JewishDateEnglish \hspace{1cm} Haifa \hspace{1cm} \iitthesis@GregorianDateEnglish
    \end{center}
  }}
 \end{center}
}

\newcommand{\maketitleEnglish}{%
 \begin{center}

  \vspace*{\stretch{1}}
  \begin{spacing}{1}
    \Huge \textbf{\iitthesis@titleEnglish}
  \end{spacing}
  \Large

  \vspace*{\stretch{1}}

  Research Thesis

  \vspace*{\stretch{0.5}}

  \parbox{4in}{
    \normalsize
    \begin{center}
      Submitted in partial fulfillment of the requirements \\
      for the degree of \iitthesis@degreeEnglish
    \end{center}
  }

  \vspace*{\stretch{2}}

  {\LARGE \textbf{\iitthesis@authorEnglish}}

  \vspace*{\stretch{3}}

  \parbox{3.5in}{
    \normalsize
    \begin{center}
      Submitted to the Senate \\
      of the Technion {\textemdash} Israel Institute of Technology
      \iitthesis@JewishDateEnglish \hspace{1cm} Haifa \hspace{1cm} \iitthesis@GregorianDateEnglish
    \end{center}
  }
 \end{center}
}

\newcommand{\makeacknowledgementsEnglish}{%

  \noindent \iitthesis@supervisionEnglish

  \ifx\iitthesis@publicationInfoEnglish\@empty
  \else
    \medskip
    \noindent \iitthesis@publicationInfoEnglish

  \fi
  \ifbool{iitthesis-includeack}{
    %\vspace*{\stretch{1}}
    \medskip

    \begin{center}
    \textbf{\Large \textsc{Acknowledgements}}
    \end{center}
    \noindent
    \iitthesis@personalAcknowledgementEnglish

    \smallskip
    \vspace*{\stretch{2}}
  }{
    \vspace*{\stretch{1}}
  }
  \noindent \iitthesis@financialAcknowledgementEnglish
}

\newcommand{\makeabstractEnglish}{%
 \chapter*{Abstract}
 \addcontentsline{toc}{chapter}{Abstract}
 \addcontentsline{cot}{chapter}{תקציר}

 \iitthesis@abstractEnglish
}

% The glossaries package generates a glossary automatically and generates 
% first use explanation of an acronym.
\RequirePackage[automake]{glossaries-extra}

\newcommand*{\formatglossarydescription}[1]{%
  \ifglsfieldeq{#1}{long}{}{%
    % Empty acronym long name, so show only the description
    \glossentrydesc{#1}%
  }{% else
    \glsentrylong{#1} (\glossentrydesc{#1})%
  }%
}

% based on https://tex.stackexchange.com/a/565077
\newglossarystyle{iitthesis}{%
    \renewenvironment{theglossary}%
    {\begin{longtable}{p{2cm}@{:\quad}lp{\glspagelistwidth}}}%
        {\end{longtable}}%
    \renewcommand*{\glossaryheader}{%                   setting the table's header
        %\bfseries  & \bfseries Meaning \bfseries Description
        %\\\tabularnewline\endhead
        }%
    \renewcommand*{\glsgroupheading}[1]{}%              no heading between groups
    \renewcommand*{\glossentry}[2]{%                    main entries displayed 
        \textbf{\glstarget{##1}{\glossentryname{##1}}}% name
        & % meaning
        \formatglossarydescription{##1}% description
        & ##2 % page list
        \tabularnewline%                                end of row
    }%
    \renewcommand*{\glsgroupskip}{}%                    no distance between groups
}

\renewcommand{\glossarysection}[2][]{}
\newcommand{\makeabbreviationsAndNotation}{%
 \chapter*{Abbreviations and Notations}
 \addcontentsline{toc}{chapter}{Abbreviations and Notations}
 \addcontentsline{cot}{chapter}{רשימת קיצורים וסמלים}
 \printglossary[title=,style=iitthesis]
}

% Like \cleardoublepage, but instead of getting you to the next recto
% page, it gets you to the next verso page; see:
% http://tex.stackexchange.com/q/11707/5640
\newcommand*{\cleartoleftpage}{%
  \clearpage
    \if@twoside
    \ifodd\c@page
      \hbox{}\newpage
      \if@twocolumn
        \hbox{}\newpage
      \fi
    \fi
  \fi
}

% Workaround for the verso -> switch triggered by our restarting of numbering;
% see:
% http://tex.stackexchange.com/q/36011/5640
%
% example:
% \displayedpagenumbering}{roman}{9}
% will make the page number printed at the bottom of the page be IX in Roman
% numerals (with X on the next page, then XI etc.) - but will not change the
% value of the 'page' counter.
%
\newcommand{\displayedpagenumbering}[2]{%
  \edef\@tempcntval{\@arabic{\value{page}}}
  \long\@namedef{@#1withoffset}##1{\csname @#1\endcsname{\numexpr ##1 - \@tempcntval + #2\relax}}%
  \pagenumbering{#1withoffset}%
  \setcounter{page}{\@tempcntval}%
}

% This is used in the workaround for the first ToC page being numbered
% without our requesting it to be
\newcommand{\emptypagenumbering}{%
  \@namedef{@emptynumbering}##1{\relax}%
  \pagenumbering{emptynumbering}%
}


\newcommand{\makecoverHebrew}{

 \begin{hebrew}
 \begin{center}
   \vspace*{\stretch{1}}
   \begin{spacing}{1}
     \Huge \textbf{\iitthesis@titleHebrew}
   \end{spacing}
   \Large

   \vspace*{\stretch{1}}

   \vphantom{חיבור על מחקר}

   \vspace*{\stretch{0.5}}

   \vphantom{\parbox{3.5in}{
     \normalsize
     \begin{center}
       לשם מילוי חלקי של הדרישות לקבלת התואר \\
       \iitthesis@degreeHebrew
     \end{center}
  }}

  \vspace*{\stretch{2}}

  {\LARGE \textbf{\iitthesis@authorHebrew}}

  \vspace*{\stretch{3}}

  \vphantom{\parbox{3in}{
     \normalsize
     \begin{center}
       מוגש לסנט הטכניון {\textemdash} מכון טכנולוגי לישראל
       \iitthesis@JewishDateHebrew
       \hspace{0.75cm} חיפה \hspace{0.75cm}
       \iitthesis@GregorianDateHebrew
     \end{center}
  }}
 \end{center}
 \end{hebrew}
}

\newcommand{\maketitleHebrew}{
 \begin{hebrew}
 \begin{center}

  \vspace*{\stretch{1}}
  \begin{spacing}{1}
    \Huge \textbf{\iitthesis@titleHebrew}
  \end{spacing}
  \Large

  \vspace*{\stretch{1}}

  חיבור על מחקר

  \vspace*{\stretch{0.5}}

  \parbox{3.5in}{
    \normalsize
    \begin{center}
      לשם מילוי חלקי של הדרישות לקבלת התואר \\
      \iitthesis@degreeHebrew
    \end{center}
  }

  \vspace*{\stretch{2}}

  {\LARGE \textbf{\iitthesis@authorHebrew}}

  \vspace*{\stretch{3}}

  \parbox{4in}{
     \normalsize
     \begin{center}
       הוגש לסנט הטכניון {\textemdash\relax} מכון טכנולוגי לישראל \\
       \iitthesis@JewishDateHebrew
       \hspace{0.75cm} חיפה \hspace{0.75cm}
       \iitthesis@GregorianDateHebrew
     \end{center}
  }
 \end{center}
 \end{hebrew}
}

\newcommand{\makeacknowledgementsHebrew}{
  \begin{hebrew}
  \noindent \iitthesis@supervisionHebrew

  \ifx\iitthesis@publicationInfoHebrew\@empty
  \else
    \medskip
    \noindent \iitthesis@publicationInfoHebrew

  \fi

  \ifbool{iitthesis-includeack}{
    %\vspace*{\stretch{1}}
    \medskip
    \begin{center}
    \textbf{\Large \textsc{תודות}}
    \end{center}
    \noindent
    \iitthesis@personalAcknowledgementHebrew

    \vspace*{\stretch{2}}
  }{
    \vspace*{\stretch{1}}
  }
  \noindent \iitthesis@financialAcknowledgementHebrew
  \end{hebrew}
}

\newcommand{\makeabstractHebrew}{
  \begin{hebrew}
  \setlist[itemize,1]{label={\fontfamily{cmr}\fontencoding{T1}\selectfont\textbullet}}
  \chapter*{\texthebrew{תקציר}}
  \addcontentsline{cot}{chapter}{תקציר עברי}
  \begin{english}
  \addcontentsline{toc}{chapter}{Hebrew Abstract}
  \end{english}
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{10pt}

  \iitthesis@abstractHebrew

  \end{hebrew}
}

% ----------------------------------------------------------
%
% Commands which may be of some use in the main matter (and are
% not used in the front or back matter)
%

% The following commented-out commands have been suggested by Ido Tal,
% to overcome problems with the two-language sectioning commands; the
% pre-existing commands (which should be available - at least with LaTeX2e
% and babel, perhaps requiring some package inclusion) are:
%  \bpart{hebrew}{english}
%  \bchapter{hebrew}{english}
%  \bsection{hebrew}{english}
%  \bsubsection{hebrew}{english}
%  \bsubsubsection{hebrew}{english}
%  \bcaption{hebrew}{english}
%  \bchapternn{hebrew}{english} - replaces \chapter*
%  \bsectionnn{hebrew}{english} - replaces \section*

\endinput
