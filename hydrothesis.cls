%% hydrothesis.cls
%% LaTeX template for creating masters's theses.
%% This file is a modification of the Hagenberg Thesis package (https://github.com/Digital-Media/HagenbergThesis) for creating bachelors's and masters's theses
%% Author: Robin Schwemmle (robin.schwemmle@venus.uni-freiburg.de)
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hydrothesis}[2018/02/08]

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode
\ifpdf{}% \typeout{hydrothesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hydrothesis: *** LaTeX NOT running in PDF mode ***}}
\fi


%% Commands for Title Pages (used in class options) ---------------------------

\newcommand{\hydro@MainLanguage}{english}	% also referenced in hydro.sty
\newcommand{\@mastertitlepages}{}
\newcommand{\@maketitlepages}{\@mastertitlepages}  %Default: Master's thesis


\newcommand{\@titlepagefont}{\sffamily}

%% Class options --------------------------------------------------------------

\DeclareOption{master}{
	\renewcommand{\@maketitlepages}{\@mastertitlepages}
}

\DeclareOption{english}{%
	\renewcommand{\hydro@MainLanguage}{english}
}

\DeclareOption*{%
	\ClassWarning{hydrothesis}{Unknown document option '\CurrentOption'.}
}

\ProcessOptions


%% Paper Options and Style File -----------------------------------------------

\LoadClass[a4paper,12pt,openany]{book}
\RequirePackage[top=30mm,bottom=30mm,left=30mm,right=30mm]{geometry} %showframe

\RequirePackage{hydro}	% load associated style file hydro.sty


%% Setup for Pages in the Front Matter ----------------------------------------

% General Commands

\newcommand{\@institute}{\@MissingArg{Institute not specified!}}
\newcommand{\institute}[1]{%
	\renewcommand{\@institute}{#1}
}
\newcommand{\@university}{\@MissingArg{University not specified!}}
\newcommand{\university}[1]{%
	\renewcommand{\@university}{#1}
}

\newcommand{\@place}{\@MissingArg{Place not specified!}}
\newcommand{\place}[1]{%
	\renewcommand{\@place}{#1}
}

\newcommand{\@datetitle}{\@MissingArg{Date not specified!}}
\newcommand{\datetitle}[1]{%
	\renewcommand{\@datetitle}{#1}
}

\newcommand{\@datesub}{\@MissingArg{Date of Submission not specified!}}
\newcommand{\datesub}[1]{%
	\renewcommand{\@datesub}{#1}
}

\newcommand{\@supervisor}{\@MissingArg{Supervisor not specified!}}
\newcommand{\supervisor}[1]{%
	\renewcommand{\@supervisor}{#1}
}

\newcommand{\@cosupervisor}{\@MissingArg{Co-Supervisor not specified!}}
\newcommand{\cosupervisor}[1]{%
	\renewcommand{\@cosupervisor}{#1}
}

\newcommand{\@titleimage}[0]{}
\newcommand{\titleimage}[1]{%
	\renewcommand{\@titleimage}{#1}
}

\newcommand{\maketitleimage}[0]{%
\ifthenelse{\equal{\@titleimage}{}}%
	{\vspace*{30mm}}%
	{\includegraphics[height=120mm]{\@titleimage}}%
}

%% Commands for Creating the Title Pages --------------------------------------

%% adds blank space after each letter (http://stackoverflow.com/a/3951837)
\newcommand{\@addspaces}[1]{%
  \@tfor\letter:=#1\do{%
    \letter\thinspace%	%\space
  }%
}

%% First Title Page ------------------------------------

\newcommand{\@mastertitleone}{%
\begin{titlepage}%
		\rule{0mm}{1mm}
		\vspace*{0mm}
		\begin{center}%
			\@titlepagefont %\normalfont
			\setlength{\unitlength}{1cm}
			{\textbf{\large\@institute}}
			\vskip 4mm%
			{\large\@university}
			\vskip 15mm%
			{\@author}%
			\vskip 15mm%
			\begin{spacing}{1.5}
			{\LARGE\@title}
			\end{spacing}
			\vskip 10mm%
			\maketitleimage%
			\vskip 10mm%
			{{MSc-Thesis under the guidance of }\@supervisor}%
			\vskip 4mm%
			{{\@place}, {\@datetitle}}%
		\end{center}%
		\vfil%
\end{titlepage}%
}

%% Second Title Page ------------------------------------

\newcommand{\@mastertitletwo}{%
\begin{titlepage}%
		\rule{0mm}{1mm}
		\vspace*{0mm}
		\begin{center}%
			\@titlepagefont %\normalfont
			\setlength{\unitlength}{1cm}
			{\textbf{\large\@institute}}
			\vskip 4mm%
			{\large\@university}
			\vskip 40mm%
			{\@author}%
			\vskip 40mm%
			\begin{spacing}{1.5}
			{\LARGE\@title}
			\end{spacing}
			\vskip 40mm%
			{{Examiner: }\@supervisor}%
			\vskip 4mm%
			{{Co-Examiner: }\@cosupervisor}%
			\vskip 30mm%
			{{MSc-Thesis under the guidance of }\@supervisor}%
			\vskip 4mm%
			{{\@place}, {\@datetitle}}%
		\end{center}%
		\vfil%
\end{titlepage}%
}

%% Declaration Page ------------------------------------

\newcommand{\leadingzero}[1]{\ifnum #1<10 0\the#1\else\the#1\fi}

\newcommand{\@declarationpage}{%
	\begin{english}
		\chapter*{Declaration of Authorship}
		\noindent
		I hereby declare and confirm that this thesis is entirely the result of my own original work.
		Where other sources of information have been used, they have been indicated as such and properly
		acknowledged. I further declare that this or similar work has not been submitted for credit elsewhere.
		\par
		\vspace{10mm}
		\noindent
		%\@placeanddate, \the\year-\leadingzero{\month}-\leadingzero{\day} %http://de.wikibooks.org/wiki/LaTeX-W%F6rterbuch:_today
		\@place, \@datesub
		\par
		\vspace{12mm}
		\noindent
		\@author
	\end{english}
}

%% Assembly of title pages ----------------------------------------------------

\renewcommand{\@mastertitlepages}{
	\@mastertitleone
	\@mastertitletwo
	\@declarationpage
}

% Add PDF meta data and create title pages

\renewcommand{\maketitle}{	%replace standard LaTeX-command
	\hypersetup{
			pdftitle={\@title},
			pdfauthor={\@author},
			pdfsubject={Hydrology, \@place, \@datetitle},
			pdfcreator={LaTeX using class hydrothesis [\hydroDate]},
			pdfproducer={pdflatex},
			pdfkeywords={}
	}%

	\@maketitlepages
}

%% Additional packages ----------------------------------------------

\RequirePackage{hydromath}
\RequirePackage{hydroheadings}
\RequirePackage{hydroabbrev}
\RequirePackage{hydrolistings}
\RequirePackage{hydrobib}

\endinput
