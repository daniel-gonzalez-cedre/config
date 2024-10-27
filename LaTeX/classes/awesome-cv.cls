%% Start of file `awesome-cv.cls'.
% Awesome CV Class File

%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{awesome-cv}[Modified Curriculum Vitae Class]
% \NeedsTeXFormat{LaTeX2e}

\def\HomeDir{/Users/cedre}

\newif\ifitalicsections
% \italicsectionstrue
\italicsectionsfalse

\ifitalicsections
  \newcommand{\sectionshape}{\bfseries\itshape}
\else
  \newcommand{\sectionshape}{\bfseries}
\fi

\newif\ifitalicheaders
% \italicheaderstrue
\italicheadersfalse

\ifitalicheaders
  \newcommand{\headershape}{\bfseries\itshape}
\else
  \newcommand{\headershape}{\bfseries}
\fi

%-------------------------------------------------------------------------------
%                Class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% Options for draft or final
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
% Inherit options of article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

%-------------------------------------------------------------------------------
%                3rd party packages
%-------------------------------------------------------------------------------
% Needed to make fixed length table
\RequirePackage{array}
% Needed to handle list environment
\RequirePackage{enumitem}
% Needed to handle text alignment
\RequirePackage{ragged2e}
% Needed to configure page layout
\RequirePackage[letterpaper]{geometry}
% \RequirePackage[top=2.0cm,  % top=2.0cm,
                % left=1.8cm,  % left=2.0cm,
                % right=1.8cm,  % right=2.0cm,
                % bottom=2.0cm,  % bottom=2.0cm,
                % footskip=0.5cm,  % footskip=0.5cm
                % letterpaper]{geometry}
% Needed to make header & footer effeciently
\RequirePackage{fancyhdr}
% Needed to manage colors
\RequirePackage{xcolor}
% Needed to use \ifxetex-\else-\fi statement
\RequirePackage{ifxetex}
% Needed to use \if-\then-\else statement
\RequirePackage{xifthen}
% Needed to use a toolbox of programming tools
\RequirePackage{etoolbox}
% Needed to change line spacing in specific environment
\RequirePackage{setspace}
% Needed to manage fonts
\RequirePackage{fontspec}
% To support LaTeX quoting style
\defaultfontfeatures{Ligatures=TeX}
% Needed to manage math fonts
% \RequirePackage{unicode-math}
\RequirePackage{amsmath}
% Needed to use icons from font-awesome
% \RequirePackage{fontawesome5}
\RequirePackage[default,opentype]{sourcesanspro}
% Needed for the photo ID
\RequirePackage[skins]{tcolorbox}
% Needed to deal a paragraphs
\RequirePackage{parskip}
\RequirePackage{makecell}
\RequirePackage{lastpage}
\RequirePackage[normalem]{ulem}
\RequirePackage{setspace}
\RequirePackage{changepage}
% Needed to deal hyperlink
\RequirePackage[hidelinks,unicode]{hyperref}
\hypersetup{%
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={},
  colorlinks=false,
  linkcolor=red,
  citecolor=green,
  urlcolor=blue,
}


%-------------------------------------------------------------------------------
%                Configuration for directory locations
%-------------------------------------------------------------------------------
% Configure a directory location for fonts(default: 'fonts/')
\newcommand*{\fontdir}[1][\HomeDir/LaTeX/fonts/]{\def\@fontdir{#1}}
\fontdir


%-------------------------------------------------------------------------------
%                Configuration for layout
%-------------------------------------------------------------------------------
%% Page Layout
% Configure page margins with geometry
\geometry{%
  top=2.0cm,  % top=2.0cm,
  left=1.8cm,  % left=2.0cm,
  right=1.8cm,  % right=2.0cm,
  bottom=2.0cm,  % bottom=2.0cm,
  footskip=0.75cm,  % footskip=0.5cm
}

%% Header & Footer
% Set offset to each header and footer
\fancyhfoffset{0.5cm}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
% Clear all header & footer fields
\fancyhf{}
% Enable if you want to make header or footer using fancyhdr
\pagestyle{fancy}


%-------------------------------------------------------------------------------
%                Configuration for colors
%-------------------------------------------------------------------------------
\newcommand{\PaperColor}{paperwhite}
% \input{colors}
\input{\HomeDir/LaTeX/preambles/2.colors}
% Text colors
\colorlet{darktext}{black}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
\colorlet{lighttext}{lightgray}
\colorlet{sectiondivider}{lightgray}
% Miscellaneous colors
% School colors
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}
\definecolor{awesome-night}{HTML}{5c4f57}

% \colorlet{awesome}{black}
\colorlet{awesome}{darktext}
\colorlet{links}{darktext}

% Boolean value to switch section color highlighting
\newbool{acvSectionColorHighlight}
\setbool{acvSectionColorHighlight}{true}

% Awesome section color
\def\@sectioncolor#1#2#3{%
  \ifbool{acvSectionColorHighlight}{\textcolor{awesome}{#1#2#3}}{#1#2#3}%
}
% \def\@sectioncolor#1#2#3{%
  % \ifbool{acvSectionColorHighlight}{\textcolor{awesome!100!text}{#1}\textcolor{awesome!75!text}{#2}\textcolor{awesome!50!text}{#3}}{#1#2#3}%
% }
% \def\@sectioncolor#1#2#3#4{%
  % \ifbool{acvSectionColorHighlight}{\textcolor{awesome!100!text}{#1}\textcolor{awesome!75!text}{#2}\textcolor{awesome!50!text}{#3}\textcolor{awesome!25!text}{#4}}{#1#2#3#4}%
% }

\newcommand{\skipdot}{\color{lighttext}{\ $\cdot$\ }}
\newcommand{\spacedot}{\color{lighttext}{\enspace$\cdot$\enspace}}
\newcommand{\lowerspacedot}{\color{lighttext}{\enspace\raisebox{-0.5pt}{$\cdot$}\enspace}}


%-------------------------------------------------------------------------------
%                Configuration for fonts
%-------------------------------------------------------------------------------
% Set font for header (default is Roboto)
\newfontfamily\tufte[
  Path=\@fontdir,
  UprightFont=*-roman-old-style-figures.ttf,
  ItalicFont=*-display-italic-old-style-figures.ttf,
  BoldFont=*-bold-line-figures.ttf,
  BoldItalicFont=*-semi-bold-old-style-figures.ttf,
]{tufte}
\newfontfamily\palatino[
  Path=\@fontdir,
  UprightFont=*.ttf,
  ItalicFont=*-italic.ttf,
  BoldFont=*-bold.ttf,
  BoldItalicFont=*-bold-italic.ttf,
]{Palatino}
\newfontfamily\hoefler[
  Path=\@fontdir,
  UprightFont=*-Regular.ttf,
  ItalicFont=*-Italic.ttf,
  BoldFont=*-Bold.ttf,
  BoldItalicFont=*-BoldItalic.ttf,
]{Hoefler}
\newfontfamily\ebgaramond[
  Path=\@fontdir,
  UprightFont=*-Regular.ttf,
  ItalicFont=*-Italic.ttf,
  BoldFont=*-Bold.ttf,
  BoldItalicFont=*-BoldItalic.ttf,
]{EBGaramond}
\newfontfamily\cormorantgaramond[
  Path=\@fontdir,
  UprightFont=*-Medium.ttf,
  ItalicFont=*-MediumItalic.ttf,
  BoldFont=*-Bold.ttf,
  BoldItalicFont=*-BoldItalic.ttf,
]{CormorantGaramond}
\newfontfamily\roboto[
  Path=\@fontdir,
  UprightFont=*-Regular.ttf,
  ItalicFont=*-Italic.ttf,
  BoldFont=*-Bold.ttf,
  BoldItalicFont=*-BoldItalic.ttf,
]{Roboto}
\newfontfamily\robotolight[
  Path=\@fontdir,
  UprightFont=*-Thin.ttf,
  ItalicFont=*-ThinItalic.ttf,
  BoldFont=*-Medium.ttf,
  BoldItalicFont=*-MediumItalic.ttf,
]{Roboto}

\newcommand*{\headerfont}{\ebgaramond}
\newcommand*{\footerfont}{\ebgaramond}
\newcommand*{\bodyfont}{\ebgaramond}
\newcommand*{\bodyfontlight}{\ebgaramond}

\newcommand*{\stremph}[1]{\textit{\textbf{\textcolor{graytext}{#1}}}}
% \renewcommand*{\emph}[1]{\textit{\textcolor{text}{#1}}}
% \renewcommand*{\strong}[1]{\textbf{\textcolor{text}{#1}}}
\renewcommand*{\emph}[1]{\textit{#1}}
\renewcommand*{\strong}[1]{\textbf{#1}}

%-------------------------------------------------------------------------------
%                Configuration for styles
%-------------------------------------------------------------------------------
% Configure styles for each CV elements
% For fundamental structures
\newcommand*{\headerfirstnamestyle}[1]{{\fontsize{32pt}{1em}\headerfont\color{graytext} #1}}
\newcommand*{\headerlastnamestyle}[1]{{\fontsize{32pt}{1em}\headerfont\bfseries\color{awesome} #1}}
\newcommand*{\headersubtitlestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\scshape\color{text}\MakeLowercase{#1}}}
\newcommand*{\headeraddressstyle}[1]{{\fontsize{8pt}{1em}\headerfont\itshape\color{lighttext} #1}}
\newcommand*{\headersocialstyle}[1]{{\fontsize{11pt}{1em}\bodyfont\itshape\color{graytext} #1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\itshape\color{darktext} #1}}
\newcommand*{\footerstyle}[1]{{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext} #1}}
\newcommand*{\sectionstyle}[1]{{\fontsize{16pt}{1em}\bodyfont\sectionshape\color{text}\@sectioncolor #1}}
\newcommand*{\subsectionstyle}[1]{{\fontsize{11pt}{1em}\bodyfont\scshape\textcolor{text}{\MakeLowercase{#1}}}}
\newcommand*{\paragraphstyle}{\fontsize{9pt}{1em}\bodyfontlight\upshape\color{text}}

% For elements of entry
\newcommand*{\entrytitlestyle}[1]{{\fontsize{11pt}{1em}\bodyfont\headershape\color{text} #1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
% \newcommand*{\entrydatestyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\bfseries\itshape\color{awesome} #1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\itshape\color{text} #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
\newcommand*{\entrysubjectstyle}[1]{{\fontsize{11pt}{1em}\bodyfont\bfseries\color{graytext} #1}}
\newcommand*{\entrypostscriptstyle}[1]{{\fontsize{11pt}{1em}\bodyfont\bfseries\itshape\color{lighttext} #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\upshape\color{text} #1}}

% For elements of teaching
\newcommand*{\teachingtitlestyle}[1]{{\fontsize{11pt}{1em}\bodyfont\headershape\color{text} #1}}
\newcommand*{\teachingpositionstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{text}\MakeLowercase{#1}}}
\newcommand*{\teachingcoursestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
\newcommand*{\teachingsizestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{lighttext}\MakeLowercase{#1}}}
% \newcommand*{\teachingtitlestyle}[1]{{\fontsize{12pt}{1em}\bodyfont\itshape\color{text} #1}}
\newcommand*{\teachingtopicstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{graytext} #1}}
\newcommand*{\teachinglocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\bfseries\itshape\color{text} #1}}
\newcommand*{\teachingdatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext} \MakeLowercase{#1}}}

% For elements of honor
\newcommand*{\honortitlestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorpositionstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\bfseries\color{darktext} #1}}
\newcommand*{\honordatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{graytext} #1}}
\newcommand*{\honorconferralstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{graytext} #1}}
\newcommand*{\honorlocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{text} #1}}

\newcommand*{\servicedatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{graytext} #1}}
\newcommand*{\serviceshortstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{lighttext} #1}}
\newcommand*{\servicevenuestyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{darktext} #1}}

% For elements of skill
\newcommand*{\skilltypestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{text} #1}}
\newcommand*{\skilldatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{graytext} #1}}
\newcommand*{\skillsetstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\color{graytext} #1}}
\newcommand*{\skillformstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{graytext} #1}}
% \newcommand*{\skilllocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{awesome} #1}}
\newcommand*{\skilllocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{text} #1}}

% For elements of publication
\newcommand*{\pubvenuestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{lighttext} #1}}

% For elements of subentry
\newcommand*{\subentrytitlestyle}[1]{{\fontsize{8pt}{1em}\bodyfont\mdseries\color{graytext} #1}}
\newcommand*{\subentrypositionstyle}[1]{{\fontsize{7pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
\newcommand*{\subentrydatestyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\itshape\color{graytext} #1}}
\newcommand*{\subentrylocationstyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\bfseries\itshape\color{awesome} #1}}
\newcommand*{\subdescriptionstyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% For elements of the cover letter
\newcommand*{\lettersectionstyle}[1]{{\fontsize{16pt}{1em}\bodyfont\sectionshape\color{text}\@sectioncolor #1}}
% \newcommand*{\lettersubsectionstyle}[1]{{\fontsize{12pt}{1em}\bodyfont\bfseries\color{text}\@sectioncolor #1}}
\newcommand*{\lettersubsectionstyle}[1]{{\fontsize{12pt}{1em}\bodyfont\bfseries\itshape\color{text}\@sectioncolor #1}}
\newcommand*{\recipienttitlestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\itshape\color{graytext} #1}}
\newcommand*{\recipientdepartmentstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\itshape\color{text} #1}}
\newcommand*{\recipientuniversitystyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\itshape\color{graytext} #1}}
\newcommand*{\recipientaddressstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
\newcommand*{\lettertitlestyle}[1]{{\fontsize{10pt}{1em}\bodyfontlight\bfseries\color{darktext} \underline{#1}}}
\newcommand*{\letterdatestyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\itshape\color{graytext} #1}}
% \newcommand*{\lettertextstyle}{\fontsize{11pt}{1.4em}\bodyfontlight\upshape\color{text}}
% \newcommand*{\letterinfostyle}{\fontsize{9pt}{1.4em}\bodyfontlight\upshape\color{text}}
\newcommand*{\lettertextstyle}{\fontsize{\lettertextsize}{\lettertextheight}\bodyfontlight\upshape\color{text}}
\newcommand*{\letternamestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\itshape\color{darktext} #1}}
\newcommand*{\letterpositionstyle}[1]{{\fontsize{10pt}{1em}\bodyfont\itshape\color{graytext} #1}}
\newcommand*{\letterdepartmentstyle}[1]{{\fontsize{10pt}{1em}\bodyfont\itshape\color{graytext} #1}}
\newcommand*{\letteruniversitystyle}[1]{{\fontsize{10pt}{1em}\bodyfont\itshape\color{graytext} #1}}
\newcommand*{\closingnamestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\itshape\color{text} #1}}
\newcommand*{\closingpositionstyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\itshape\color{graytext} #1}}
\newcommand*{\closingdepartmentstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
\newcommand*{\closinguniversitystyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext}\MakeLowercase{#1}}}
\newcommand*{\closingphonestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{lighttext}\MakeLowercase{#1}}}

\newcommand*{\letterenclosurestyle}[1]{{\fontsize{10pt}{1em}\bodyfontlight\itshape\color{lighttext} #1}}

\def\lettertextsize{9pt}
\def\lettertextheight{1.4em}
% \newcommand*{\lettertextsize}[1]{#1}
% \newcommand*{\lettertextheight}[1]{#1}

%-------------------------------------------------------------------------------
%                Commands for personal information
%-------------------------------------------------------------------------------
% Define photo ID
% Usage: \photo[circle|rectangle,edge|noedge,left|right]{<path-to-image>}
\newcommand{\photo}[2][circle,edge,left]{%
  \def\@photo{#2}
  \@for\tmp:=#1\do{%
    \ifthenelse{\equal{\tmp}{circle} \or \equal{\tmp}{rectangle}}%
      {\let\@photoshape\tmp}{}%
    \ifthenelse{\equal{\tmp}{edge} \or \equal{\tmp}{noedge}}%
      {\let\@photoedge\tmp}{}%
    \ifthenelse{\equal{\tmp}{left} \or \equal{\tmp}{right}}%
      {\let\@photoalign\tmp}{}%
  }%
}
\def\@photoshape{circle}
\def\@photoedge{edge}
\def\@photoalign{left}

% Define writer's name
% Usage: \name{<firstname>}{<lastname>}
% Usage: \firstname{<firstname>}
% Usage: \lastname{<lastname>}
% Usage: \familyname{<familyname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}

\newcommand*{\position}[1]{\def\@position{#1}}
\newcommand*{\department}[1]{\def\@department{#1}}
\newcommand*{\university}[1]{\def\@university{#1}}

% Define writer's address
% Usage: \address{<address>}
\newcommand*{\address}[1]{\def\@address{#1}}

% Define writer's subtitle
% Usage: \subtitle{<subtitle>}
\newcommand*{\subtitle}[1]{\def\@subtitle{#1}}

% Defines writer's mobile (optional)
% Usage: \mobile{<mobile number>}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}

% Defines writer's email (optional)
% Usage: \email{<email address>}
\newcommand*{\email}[1]{\def\@email{#1}}

% Defines supp matt (optional)
% Usage: \supplemental{<link>}
\newcommand*{\supplemental}[1]{\def\@supplemental{#1}}


% Defines writer's date of birth (optional)
% Usage: \dateofbirth{<date>}
\newcommand*{\dateofbirth}[1]{\def\@dateofbirth{#1}}

% Defines writer's homepage (optional)
% Usage: \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% Defines writer's github (optional)
% Usage: \github{<github-nick>}
\newcommand*{\github}[1]{\def\@github{#1}}

% Defines writer's gitlab (optional)
% Usage: \gitlab{<gitlab-nick>}
\newcommand*{\gitlab}[1]{\def\@gitlab{#1}}

% Defines writer's bitbucket (optional)
% Usage: \bitbucket{<bitbucket-nick>}
\newcommand*{\bitbucket}[1]{\def\@bitbucket{#1}}

% Defines writer's stackoverflow profile (optional)
% Usage: \stackoverflow{<so userid>}{<so username>}
%   e.g.https://stackoverflow.com/users/123456/sam-smith
%       would be \stackoverflow{123456}{sam-smith}
\newcommand*{\stackoverflow}[2]{\def\@stackoverflowid{#1}\def\@stackoverflowname{#2}}

% Defines writer's linked-in (optional)
% Usage: \linkedin{<linked-in-nick>}
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}

% Defines writer's orcid (optional)
% Usage: \orcid{<orcid-num>}
\newcommand*{\orcid}[1]{\def\@orcid{#1}}

% Defines writer's twitter (optional)
% Usage: \twitter{<twitter handle>}
\newcommand*{\twitter}[1]{\def\@twitter{#1}}

% Defines writer's Mastodon (optional)
% Usage: \mastodon{<instance>}{<mastodon-nick>}
\newcommand*{\mastodon}[2]{\def\@mastodoninstance{#1}\def\@mastodonname{#2}}

% Defines writer's resarchgate (optional)
% Usage: \researchgate{<researchgate-account>}
\newcommand*{\researchgate}[1]{\def\@researchgate{#1}}

% Defines writer's skype (optional)
% Usage: \skype{<skype account>}
\newcommand*{\skype}[1]{\def\@skype{#1}}

% Defines writer's reddit (optional)
% Usage: \reddit{<reddit account>}
\newcommand*{\reddit}[1]{\def\@reddit{#1}}

% Defines writer's xing (optional)
% Usage: \xing{<xing name>}
\newcommand*{\xing}[1]{\def\@xing{#1}}

% Defines writer's medium profile (optional)
% Usage: \medium{<medium account>}
\newcommand*{\medium}[1]{\def\@medium{#1}}

% Defines writer's kaggle (optional)
% Usage: \kaggle{<kaggle handle>}
\newcommand*{\kaggle}[1]{\def\@kaggle{#1}}

% Defines writer's google scholar profile (optional)
% Usage: \googlescholar{<googlescholar userid>}{<googlescholar username>}
% e.g.https://scholar.google.co.uk/citations?user=wpZDx1cAAAAJ
% would be \googlescholar{wpZDx1cAAAAJ}{Name-to-display-next-icon}
% If 'googlescholar-name' is not provided than it defaults to
% '\firstname \lastname'
\newcommand*{\googlescholar}[2]{%
  \def\@googlescholarid{#1}%
  \ifthenelse{\equal{#2}{}}{%
    \def\@googlescholarname{\@firstname~\@lastname}%
  }{%
    \def\@googlescholarname{#2}%
  }%
}

% Defines writer's extra information (optional)
% Usage: \extrainfo{<extra information>}
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}

% Defines writer's quote (optional)
% Usage: \quote{<quote>}
\renewcommand*{\quote}[1]{\def\@quote{#1}}

% Defines recipient's information (cover letter only)
% Usage: \recipient{<recipient name>}{<recipient address>}
% Usage: \recipientname{<recipient name>}
% Usage: \recipientaddress{<recipient address>}
% \newcommand*{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}
\newcommand*{\recipient}[5]{\def\@recipientname{#1}\def\@recipientdepartment{#1}%
                            \def\@recipientuniversity{#2}%
                            \ifthenelse{\isempty{#3}}{}{\def\@recipientaddressbuilding{#3}}%
                            \ifthenelse{\isempty{#4}}{}{\def\@recipientaddressstreet{#4}}%
                            \def\@recipientaddresscountry{#5}}
\newcommand*{\recipientname}[1]{\def\@recipientname{#1}}
\newcommand*{\recipientdepartment}[1]{\def\@recipientdepartment{#1}}
\newcommand*{\recipientuniversity}[1]{\def\@recipientuniversity{#1}}
\newcommand*{\recipientbuilding}[1]{\def\@recipientaddressbuilding{#1}}
\newcommand*{\recipientstreet}[1]{\def\@recipientaddressstreet{#1}}
\newcommand*{\recipientcountry}[1]{\def\@recipientaddresscountry{#1}}
% \newcommand*{\recipientaddress}[1]{\def\@recipientaddress{#1}}

% Defines the title for letter (cover letter only, optional)
% Usage: \lettertitle{<title>}
\newcommand*{\lettertitle}[1]{\def\@lettertitle{#1}}

% Defines the date for letter (cover letter only)
% Usage: \letterdate{<date>}
\newcommand*{\letterdate}[1]{\def\@letterdate{#1}}

% Defines a message of opening for letter (cover letter only)
% Usage: \letteropening{<message>}
\newcommand*{\letteropening}[1]{\def\@letteropening{#1}}

% Defines a message of closing for letter (cover letter only)
% Usage: \letterclosing{<message>}
\newcommand*{\letterclosing}[1]{\def\@letterclosing{#1}}

% Defines an enclosure for letter (cover letter only, optional)
% Usage: \letterenclosure[<enclosure name>]{<enclosure>}
\newcommand*{\letterenclname}[1][Enclosure]{\def\@letterenclname{#1}}
\newcommand*{\letterenclosure}[2][]{%
  % if an optional argument is provided, use it to redefine \enclname
  \ifthenelse{\equal{#1}{}}{}{\def\@letterenclname{#1}}
  \def\@letterenclosure{#2}
}


%-------------------------------------------------------------------------------
%                Commands for extra
%-------------------------------------------------------------------------------
%% Define helper macros a user can change easily
% Header
\newcommand{\acvHeaderNameDelim}{\space}

\newcommand{\acvHeaderBeforeNameBlockSkip}{0.0mm}
  \newcommand{\acvHeaderBeforeNameSkip}{0.0mm}
  \newcommand{\acvHeaderAfterNameSkip}{2.5mm}  % 0.0mm 2.0mm
  \newcommand{\acvHeaderAfterSubtitleSkip}{0.4mm}  % 0.4mm
\newcommand{\acvHeaderAfterNameBlockSkip}{0.0mm}

\newcommand{\acvHeaderAfterQuoteSkip}{5mm}  % 0.0mm
\newcommand{\acvHeaderAfterAddressSkip}{0mm}  % 0.0mm
\newcommand{\acvHeaderAfterSocialSkip}{0.0mm}  % 0.0mm
% \newcommand{\acvHeaderSocialSep}{\quad\textbar\quad}
\newcommand{\acvHeaderSocialSep}{\quad\textcolor{lighttext}{$\cdot$}\quad}
\newcommand{\acvHeaderIconSep}{\space}

% Others
\newcommand{\acvPubTopSkip}{0.0mm}  % default 0.0mm
\newcommand{\acvPubAuthorSkip}{-0.5mm}  % default 0.0mm
\newcommand{\acvServiceTopSkip}{-.0mm}  % default 0.0mm
\newcommand{\acvEntryTopSkip}{-1.0mm}  % default 0.0mm
\newcommand{\acvSectionTopSkip}{1.0mm}  % default 3.0mm
\newcommand{\acvSectionContentTopSkip}{0.0mm}  % default 2.5mm
\newcommand{\acvEntriesColSep}{1.0ex}  % default 1.0ex


%-------------------------------------------------------------------------------
%                Commands for utilities
%-------------------------------------------------------------------------------
% Use to align an element of tabular table
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Use to draw horizontal line with specific thickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}


%-------------------------------------------------------------------------------
%                Commands for elements of CV structure
%-------------------------------------------------------------------------------
% Define a header for CV
% Usage: \makecvheader
\newcommand*{\makecvheader}[1][C]{%
  \newcommand*{\drawphoto}{%
    \ifthenelse{\isundefined{\@photo}}{}{%
      \newlength{\photodim}
      \ifthenelse{\equal{\@photoshape}{circle}}%
        {\setlength{\photodim}{1.3cm}}%
        {\setlength{\photodim}{1.8cm}}%
      \ifthenelse{\equal{\@photoedge}{edge}}%
        {\def\@photoborder{darkgray}}%
        {\def\@photoborder{none}}%
      \begin{tikzpicture}%
        \node[\@photoshape, draw=\@photoborder, line width=0.3mm, inner sep=\photodim, fill overzoom image=\@photo] () {};
      \end{tikzpicture}
    }%
  }
  \newlength{\headertextwidth}
  \newlength{\headerphotowidth}
  \ifthenelse{\isundefined{\@photo}}{
    \setlength{\headertextwidth}{\textwidth}
    \setlength{\headerphotowidth}{0cm}
  }{%
    \setlength{\headertextwidth}{0.76\textwidth}
    \setlength{\headerphotowidth}{0.24\textwidth}
  }%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{left}}{\raggedright\drawphoto}{}
  \end{minipage}
  \begin{minipage}[c]{\headertextwidth}
    \vspace{\acvHeaderBeforeNameBlockSkip}%
    \ifthenelse{\equal{#1}{L}}{\raggedright}{\ifthenelse{\equal{#1}{R}}{\raggedleft}{\centering}}
    \vspace{\acvHeaderBeforeNameSkip}%
    \headerfirstnamestyle{\@firstname}\headerlastnamestyle{{}\acvHeaderNameDelim\@lastname}%
    \\[\acvHeaderAfterNameSkip]%
    \ifthenelse{\isundefined{\@subtitle}}{}{\headersubtitlestyle{\@subtitle\\[\acvHeaderAfterSubtitleSkip]}}%
    \ifthenelse{\isundefined{\@address}}{}{\headeraddressstyle{\@address\\[\acvHeaderAfterAddressSkip]}}%
    \headersocialstyle{%
      \newbool{isstart}%
      \setbool{isstart}{true}%
      % \ifthenelse{\isundefined{\@mobile}}%
        % {}%
        % {%
          % \href{tel:\@mobile}{\@mobile}%
          % \setbool{isstart}{false}%
        % }%
      \ifthenelse{\isundefined{\@email}}%
        {}%
        {%
          % \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{mailto:\@email}{\textcolor{links}{\@email}}%
          \setbool{isstart}{false}%
        }%
      \ifthenelse{\isundefined{\@supplemental}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          % \href{mailto:\@supplemental}{\textcolor{links}{\@supplemental}}%
          % \href{https://\@supplemental}{\textcolor{links}{\@supplemental}}%
          \href{\@supplemental}{\textcolor{links}{\textsc{supplemental materials}}}%
        }%
      \ifthenelse{\isundefined{\@homepage}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://\@homepage}{\textcolor{links}{\@homepage}}%
        }%
      \ifthenelse{\isundefined{\@dateofbirth}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          % \mbox prevents wrapping of elements%
          \mbox{\@dateofbirth}%
        }%
      \ifthenelse{\isundefined{\@googlescholarid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
            % \href{https://scholar.google.com/citations?user=\@googlescholarid}{\textcolor{links}{\@googlescholarname}}%
            \href{https://scholar.google.com/citations?user=\@googlescholarid}{\textcolor{links}{\@googlescholarid}}%
        }%
      \ifthenelse{\isundefined{\@orcid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://orcid.org/\@orcid}{\textcolor{links}{\@orcid}}%
        }%
      \ifthenelse{\isundefined{\@github}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://github.com/\@github}{\textcolor{links}{\@github}}%
        }%
      \ifthenelse{\isundefined{\@gitlab}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://gitlab.com/\@gitlab}{\@gitlab}%
        }%
      \ifthenelse{\isundefined{\@bitbucket}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://bitbucket.com/\@bitbucket}{\@bitbucket}%
        }%
      \ifthenelse{\isundefined{\@stackoverflowid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://stackoverflow.com/users/\@stackoverflowid}{\@stackoverflowname}%
        }%
      \ifthenelse{\isundefined{\@linkedin}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.linkedin.com/in/\@linkedin}{\@linkedin}%
        }%
      \ifthenelse{\isundefined{\@twitter}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://twitter.com/\@twitter}{\@twitter}%
        }%
      \ifthenelse{\isundefined{\@mastodonname}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://\@mastodoninstance/@\@mastodonname}{\@mastodonname}%
        }%
      \ifthenelse{\isundefined{\@skype}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \@skype%
        }%
      \ifthenelse{\isundefined{\@reddit}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.reddit.com/user/\@reddit}{\@reddit}%
        }%
      \ifthenelse{\isundefined{\@researchgate}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.researchgate.net/profile/\@researchgate}{\@researchgate}%
        }%
      \ifthenelse{\isundefined{\@xing}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.xing.com/profile/\@xing}{\@xing}
        }%
      \ifthenelse{\isundefined{\@medium}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://medium.com/@\@medium}{\@medium}%
        }%
      \ifthenelse{\isundefined{\@kaggle}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://kaggle.com/\@kaggle}{\@kaggle}%
        }%
      \ifthenelse{\isundefined{\@extrainfo}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \@extrainfo%
        }%
    } \\[\acvHeaderAfterSocialSkip]%
    \ifthenelse{\isundefined{\@quote}}%
      {}%
      {\headerquotestyle{\@quote\\}\vspace{\acvHeaderAfterQuoteSkip}}%
  \end{minipage}%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{right}}{\raggedleft\drawphoto}{}
  \end{minipage}
  \vspace{\acvHeaderAfterNameBlockSkip}
}

% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{\footerstyle{#1}}
  \fancyfoot[C]{\footerstyle{#2}}
  \fancyfoot[R]{\footerstyle{#3}}
}

% Define a section for CV
% Usage: \cvsection{<section-title>}
\newcommand{\cvsection}[1]{%
  \vspace{\acvSectionTopSkip}
  \sectionstyle{#1\strut\mathstrut}
  \phantomsection
  \color{sectiondivider}\vhrulefill{0.9pt}%
}

% Define a subsection for CV
% Usage: \cvsubsection{<subsection-title>}
\newcommand{\cvsubsection}[1]{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2mm}
  \subsectionstyle{#1}
  \phantomsection
}

% Define a paragraph for CV
\newenvironment{cvparagraph}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2mm}
  \paragraphstyle
}{%
  \par
  \vspace{2mm}
}

% Define an environment for cventry
\newenvironment{cventries}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
}{%
  \end{center}
}
% Define an entry of cv information
% Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
\newcommand*{\cventry}[5]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.25cm} R{4.25cm}}
    \ifempty{#2#3}
      {\entrypositionstyle{#1} & \entrylocationstyle{#4} \\}
      {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\[-0.25ex]
      \entrypositionstyle{#1} & \entrydatestyle{#4} \\[-0.25ex]}
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}}
  \end{tabular*}%
}
\newcommand*{\cveducation}[8]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 3.75cm} R{3.75cm}}
      % {\entrytitlestyle{#1} & \entrydatestyle{#4} \\[-0.25ex]
       % \entrypositionstyle{#3} & \entrylocationstyle{#5} \\[-0.25ex]
       % \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#6}}}
    \entrytitlestyle{#1}\entrysubjectstyle{{\spacedot}#2}\ifempty{#3}{}{\entrypostscriptstyle{{\spacedot}#3}} & \entrylocationstyle{#5} \\[-0.25ex]
    \entrypositionstyle{#4} & \entrydatestyle{#6}{\fontsize{9pt}{1em}\color{lighttext}\scshape~\textendash~}\entrydatestyle{#7} \\[-0.25ex]
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#8}}

  \end{tabular*}%
}
\newcommand*{\cvinternship}[6]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.25cm} R{4.25cm}}
    \ifempty{#2#3}
      {\entrypositionstyle{#1} & \entrylocationstyle{#4} \\}
      {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\[-0.25ex]
      \entrypositionstyle{#1} & \entrydatestyle{#4}{\fontsize{9pt}{1em}\color{lighttext}\scshape~\textendash~}\entrydatestyle{#5} \\[-0.25ex]}
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#6}}
  \end{tabular*}%
}
\newcommand*{\cventryblank}[4]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \entrytitlestyle{#2} & \entrydatestyle{#4} \\[-0.25ex]
    \entrypositionstyle{#1} & \entrylocationstyle{#3} \\[-0.25ex]
  \end{tabular*}%
}

\newenvironment{cvservices}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
    \setlength\tabcolsep{\acvEntriesColSep}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} l r L{\textwidth * \real{0.9125}}}
}{%
    \end{tabular*}
  \end{center}
}
% \newcommand*{\cvservice}[2]{%
  % \vspace{\acvEntryTopSkip}
  % \setlength\tabcolsep{0pt}
  % \setlength{\extrarowheight}{0pt}
  % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth} R{0.0cm}}
      % \skilltypestyle{#1}{\spacedot}\descriptionstyle{#2}
  % \end{tabular*}%
% }
\newcommand*{\cvservice}[3]{%
  \ifempty{#2}
    {\servicedatestyle{#1} && \servicevenuestyle{#3} \\}
    {\servicedatestyle{#1} & \serviceshortstyle{#2} & \servicevenuestyle{#3} \\}
}

% \newcommand*{\cventrylogo}[6]{%
  % \vspace{-1.5mm}
  % \setlength\tabcolsep{0pt}
  % \setlength{\extrarowheight}{0pt}
  % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    % \ifempty{#2#3}
      % {\entrypositionstyle{#1} & \entrylocationstyle{#4} \\}
      % {\entrytitlestyle{#2}~~\includegraphics[height=\ht\strutbox]{#6} & \entrydatestyle{#4} \\
      % \entrypositionstyle{#1} & \entrylocationstyle{#3} \\}
    % \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}}
  % \end{tabular*}%
% }

\newcommand*{\cventrydouble}[6]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \ifempty{#2#3#4}
      {\entrypositionstyle{#1} & \entrylocationstyle{#5} \\}
      {\entrytitlestyle{#3} & \entrydatestyle{#5} \\[-0.25ex]
      \entrypositionstyle{#1} & \entrylocationstyle{#4} \\[-0.25ex]
      \entrypositionstyle{#2}\\[-0.25ex]}
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#6}}
  \end{tabular*}%
}

% \newcommand*{\cventrydoublelogo}[7]{%
  % \vspace{-1.5mm}
  % \setlength\tabcolsep{0pt}
  % \setlength{\extrarowheight}{0pt}
  % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    % \ifempty{#2#3#4}
      % {\entrypositionstyle{#1} & \entrylocationstyle{#5} \\}
      % {\entrytitlestyle{#3}~~\includegraphics[height=\ht\strutbox]{#7} & \entrydatestyle{#5} \\
      % \entrypositionstyle{#1} & \entrylocationstyle{#4} \\
      % \entrypositionstyle{#2}\\}
    % \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#6}}
  % \end{tabular*}%
% }

% Define an environment for cvsubentry
\newenvironment{cvsubentries}{%
  \begin{center}
}{%
  \end{center}
}
% Define a subentry of cv information
% Usage: \cvsubentry{<position>}{<title>}{<date>}{<description>}
\newcommand*{\cvsubentry}[4]{%
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \setlength\leftskip{0.2cm}
    \subentrytitlestyle{#2} & \ifthenelse{\equal{#1}{}}
      {\subentrydatestyle{#3}}{}
    \ifthenelse{\equal{#1}{}}
      {}
      {\subentrypositionstyle{#1} & \subentrydatestyle{#3} \\}
    \ifthenelse{\equal{#4}{}}
      {}
      {\multicolumn{2}{L{17.0cm}}{\subdescriptionstyle{#4}} \\}
  \end{tabular*}
}

\newenvironment{cvteaching}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
}{%
  \end{center}
}
% Define an entry of cv information
% Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
% \newcommand*{\cvteach}[5]{%
  % \vspace{-1mm}
  % \setlength\tabcolsep{0pt}
  % \setlength{\extrarowheight}{0pt}
  % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    % \ifempty{#2#3}
      % {\teachingpositionstyle{#1} & \teachingdatestyle{#4} \\}
      % {\teachingpositionstyle{#2} & \teachinglocationstyle{#4} \\[-0.4ex]
       % \teachingtitlestyle{#1} & \teachingdatestyle{#3} \\[-0.25ex]}
    % \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}}
  % \end{tabular*}%
% }
% \newcommand*{\cvassist}[7]{%
  % \vspace{\acvEntryTopSkip}
  % \setlength\tabcolsep{0pt}
  % \setlength{\extrarowheight}{0pt}
  % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    % \teachingtitlestyle{#2} & \teachingdatestyle{#6} \\[-0.25ex]
    % % \teachingpositionstyle{#1}\teachingcoursestyle{{\spacedot}#3} & \teachingdatestyle{#4} \\[-0.25ex]
    % \teachingpositionstyle{#1}\teachingcoursestyle{{\spacedot}#3}\teachingsizestyle{{\spacedot}#4} & \teachingdatestyle{#5} \\[-0.25ex]
    % \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#7}}
  % \end{tabular*}%
% }
\newcommand*{\cvteach}[7]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \teachingtitlestyle{#2} & \teachinglocationstyle{#6} \\[-0.25ex]
    % \teachingpositionstyle{#1}\teachingcoursestyle{{\spacedot}#3} & \teachingdatestyle{#4} \\[-0.25ex]
    \teachingpositionstyle{#1}\teachingcoursestyle{{\spacedot}#3}\teachingsizestyle{{\spacedot}#4} & \teachingdatestyle{#5} \\[-0.25ex]
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#7}}
  \end{tabular*}%
}
\newcommand*{\cvteachtopics}[8]{%
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \teachingtitlestyle{#2} & \teachinglocationstyle{#6} \\[-0.25ex]
    \teachingpositionstyle{#1}\teachingcoursestyle{{\spacedot}#3}\teachingsizestyle{{\spacedot}#4} & \teachingdatestyle{#5} \\[-0.25ex]
    \teachingtopicstyle{#7} \\[-0.25ex]
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#8}}
  \end{tabular*}%
}

% Define an environment for cvhonor
\newenvironment{cvhonors}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
    % % \setlength\tabcolsep{0pt}
    % \setlength\tabcolsep{1ex}
    \setlength\tabcolsep{\acvEntriesColSep}
    \setlength{\extrarowheight}{0pt}
    % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} C{1.5cm} L{\textwidth - 4.0cm} R{2.5cm}}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} r L{\textwidth * \real{0.9125}}}
}{%
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(honor, award or something else)
% Usage: \cvhonor{<position>}{<title>}{<location>}{<date>}
\newcommand*{\cvhonor}[4]{%
  \honordatestyle{#1} & \honorpositionstyle{#2}{\spacedot}\honorconferralstyle{#3}{\spacedot}\honorlocationstyle{#4} \\
  % \skilldatestyle{#1} & \skillsetstyle{\textbf{#2}} & \skillsetstyle{\textit{#3}} & \skilllocationstyle{#4} \\
}

% Define an environment for cvskill
\newenvironment{cvskills}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
    % \setlength\tabcolsep{1ex}
    \setlength\tabcolsep{\acvEntriesColSep}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} r L{\textwidth * \real{0.9125}}}
}{%
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(skill)
% Usage: \cvskill{<type>}{<skillset>}
\newcommand*{\cvskill}[2]{%
	\skilltypestyle{#1} & \skillsetstyle{#2} \\
}

% Define an environment for cvskill
\newenvironment{cvpubs}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
    % \setlength\tabcolsep{1ex}
    \setlength\tabcolsep{\acvEntriesColSep}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} r L{\textwidth * \real{0.9125}}}
}{%
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(skill)
% Usage: \cvskill{<type>}{<skillset>}
\newcommand*{\cvpub}[4]{%
  \vspace{\acvPubAuthorSkip}
    % \skilldatestyle{#1} & \skilltypestyle{#2}{\spacedot}\skillformstyle{\normalshape\textsc{#3}} \\
    % \skilldatestyle{#1} & \skilltypestyle{#2}{\spacedot}\skillformstyle{#3} \\
    \skilldatestyle{#1} & \skilltypestyle{#2}{\spacedot}\pubvenuestyle{#3} \\
    & \skillsetstyle{#4} \\
}

% Define an environment for cvskill
\newenvironment{cvtalks}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
    \setlength\tabcolsep{\acvEntriesColSep}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} r L{\textwidth * \real{0.9125}}}
    % \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} r L{\textwidth * \real{0.4}} L{\textwidth * \real{0.125}} L{\textwidth * \real{0.275}}}
}{%
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(skill)
% Usage: \cvskill{<type>}{<skillset>}
\newcommand*{\cvtalk}[4]{%
  % \skilldatestyle{#1} & \skillsetstyle{\textbf{#2}} & \skillsetstyle{\textit{#3}} & \skilllocationstyle{#4} \\
  \skilldatestyle{#1} & \skilltypestyle{#2}{\spacedot}\skillformstyle{#3}{\spacedot}\skilllocationstyle{#4} \\
}

% Define an environment for cvitems(for cventry)
\newenvironment{cvitems}{%
  \vspace{-3.5mm}
  \begin{justify}
  \begin{itemize}[nosep,noitemsep,leftmargin=3.5ex]
    \setlength{\parskip}{0pt}
    \renewcommand{\labelitemi}{\raisebox{0.2ex}{\color{lighttext}-}}
}{%
  \end{itemize}
  \end{justify}
  \vspace{-4.0mm}
}


%-------------------------------------------------------------------------------
%                Commands for elements of Cover Letter
%-------------------------------------------------------------------------------
% Define an environment for cvletter
\newenvironment{cvletter}{%
  \lettertextstyle
}{%
}

% Define a section for the cover letter
% Usage: \lettersection{<section-title>}
\newcommand{\lettersection}[1]{%
  \par\addvspace{2.5ex}
  \phantomsection{}
  \lettersectionstyle{#1}
  \color{sectiondivider}\vhrulefill{0.9pt}
  % \par\nobreak\addvspace{0.4ex}
  \par\nobreak\addvspace{-1mm}
  \lettertextstyle
}

% \newcommand{\lettersubsection}[1]{%
  % \par\addvspace{2.5ex}
  % \phantomsection{}
  % \lettersubsectionstyle{#1}
  % \color{lighttext}\vhrulefill{0.9pt}
  % \par\nobreak\addvspace{0.4ex}
  % \lettertextstyle
% }
\newcommand{\lettersubsection}[1]{%
  \par% \addvspace{2.5ex}
  \phantomsection{}
  \lettersubsectionstyle{#1}
  % \color{lighttext}\vhrulefill{0.9pt}
  % \par\nobreak\addvspace{0.4ex}
  \quad\lettertextstyle
}

% Define a title of the cover letter
% Usage: \makelettertitle
\newcommand*{\makelettertitle}{%
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \ifthenelse{\isundefined{\@letterdate}}
  {}{\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
       \recipienttitlestyle{\hspace{-1ex}\@recipientname} & \letterdatestyle{\@letterdate}
     \end{tabular*}}
  % \begin{singlespace}
    % \recipientaddressstyle{\@recipientaddress} \\\\
  % \end{singlespace}
  \begin{itemize}[nosep,noitemsep,topsep=-5pt,leftmargin=0pt]
    \renewcommand{\labelitemi}{}
    \ifthenelse{\isundefined{\@letterdate}}
      {\item
        \recipientdepartmentstyle{\@recipientdepartment}}{}
    \item
      \recipientuniversitystyle{\@recipientuniversity}
    \ifthenelse{\isundefined{\@recipientaddressbuilding}}
      {}
      {\item
        \recipientaddressstyle{\@recipientaddressbuilding}}
    \ifthenelse{\isundefined{\@recipientaddressstreet}}
      {}
      {\item
        \recipientaddressstyle{\@recipientaddressstreet}}
    \item
      \recipientaddressstyle{\@recipientaddresscountry}
  \end{itemize}
  \ifthenelse{\isundefined{\@lettertitle}}
    {}
    {\lettertitlestyle{\@lettertitle} \\}
  \lettertextstyle{\@letteropening}
}

% Define a closing of the cover letter
% Usage: \makeletterclosing
\newcommand*{\makeletterclosing}{%
  \vspace{3.4mm}
  % \vspace{0.0mm}
  \lettertextstyle{\@letterclosing}

  \begin{itemize}[noitemsep,leftmargin=15pt]
    \renewcommand{\labelitemi}{}
    \item
      \ifthenelse{\isundefined{\@position}}
      {\closingnamestyle{\@firstname\ \@lastname}}
      {\closingnamestyle{\@firstname\ \@lastname}{\spacedot}\closingpositionstyle{\@position}}
    \item
      \closingdepartmentstyle{\@department}
    \item
      \closinguniversitystyle{\@university}
    \ifthenelse{\isundefined{\@mobile}}
      {}
      {\item
        \closingphonestyle{\@mobile}}
  \end{itemize}

  % \ifthenelse{\isundefined{\@letterenclosure}}
    % {\\}
    % {%
      % \\\\\\
      % \letterenclosurestyle{\@letterenclname: \@letterenclosure} \\
    % }
}
