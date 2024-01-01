# LaTeX Presents 
This is a LaTeX presentation package that wraps Beamer with the goal of being:
 - Media friendly (images and video)
 - Quick and easy to use, especially for academic style presentations
 - Visually consistent and simple

The excellent [pdfpc](https://pdfpc.github.io/) program is highly recommended to present the resulting PDFs.

The package uses the Beamer `frame` environment and defines [layouts](https://github.com/robotic-esp/latexpresents#layouts) for use within the frame.
Each element (i.e., row or column) of a layout can be filled with any LaTeX content, e.g., lists, math, TikZ, [images](https://github.com/robotic-esp/latexpresents#images), [videos](https://github.com/robotic-esp/latexpresents#videos), etc.
Most slides will have a hierarchy like:
```tex
\begin{frame}{title}
  %Layout{%Content}
\end{frame}
```

## Example
A very [simple example of using LaTeX Presents is available on GitHub](https://github.com/robotic-esp/latexpresents_example).
You can [see the PDF here](https://github.com/robotic-esp/latexpresents_example/blob/main/demo_presentation.pdf).



## Installation and Use
This package should be checked out as a subfolder to your LaTeX project named `latexpresents`:
```bash
git clone https://github.com/robotic-esp/latexpresents.git latexpresents
```

This package is then used in your LaTeX project directly as cloned from the repository.
Your LaTeX document's preamble should look like:
```tex
\documentclass[aspectratio=169,12pt]{beamer}
% Aspect ratios: 169 (16:9), 1610 (16:10), 149 (14:9), 32 (3:2), 141 (1.41:1), 43 (4:3), 54 (5:4)

\usepackage[package options]{latexpresents/latexpresents.sty}

%...

\begin{document}
%...
\end{document}
```
LaTeXPresents is developed/tested with `12pt` font and an `16:9` aspect ratio (sometimes 4:3). Other ratios will work to varying degrees. Other font size may also work, but some spacing bugs may appear in places like media captions.



### Package Options
The package includes the following options:
| Option (default in bold) | Description |
| --- | --- |
| `theme=PATH/TO/FILE` | Path to a user-provided theme file that defines a colour palette and logos and other common settings. The user-provided theme is applied on top of the default (logo-free) theme, so that a complete palette is always defined. See [Themes](https://github.com/robotic-esp/latexpresents#themes) |
| **`light`**, `dark` | Light or dark presentation. |
| **`pdfpc`**, `adobe` | Target PDF reader. Affects speaker notes and how videos are embedded and other things as necessary. Presentation in Linux currently requires pdfpc. Presentation in Windows or MacOS may target either pdfpc or Adobe Acrobat. Please see note. |
| **`present`**, `handout` | Compile file as a presentation or as a handout. Handouts simplify transitions and videos and do not include any extra slides. |
| **`videos`**, `novideos` | Compile file with videos or with replacement images. Combine `novideos` with `handout` to make a lightweight handout. |
| **`pagenumbers`**, `nonumbers` | Include slide numbers. |
| **`titlepage`**, `notitlepage` | Automatically include a title slide to keep your source clean. |
| **`alignedtop`**, `raggedtop` | Set the global layout default. See [Layout Options](https://github.com/robotic-esp/latexpresents#layout-options) |
| `alignedbottom`, **`raggedbottom`** | Set the global layout default. See [Layout Options](https://github.com/robotic-esp/latexpresents#layout-options) |
| `debug`, **`nodebug`** | Enable global debugging. This includes layout debugging. |

#### Note
PDFs created for presentation in pdfpc (i.e., `pdfpc` & `present`) currently embed videos with `\href` instead of using `\movie` from the `multimedia` package.
This allows pdfpc to avoid a bug in the open-source low-level PDF library that prevents autoplay but means that
 1. the videos are not actually embedded in the file and must be in the same place at presentation as during compile, and
 2. PDFs compiled for pdfpc will not work in any other PDF viewer (specifically, the videos won't).

This behaviour will change when the updated version of the library appears in enough versions of Ubuntu.

Handouts in pdfpc mode (i.e., `pdfpc` & `handout`) will use `\movie` since autostart is always disabled in handouts, anyway.
This means that they may also be usable with other PDF readers.

PDFs created for Adobe Acrobat may work in other PDF viewers, especially on Windows and MacOS.





## Layouts
Every frame must contain a layout command.
The available layout commands are:
| Layout | Description | Element sizes |
| --- | --- | --- |
| `\onecolumnfull[layout options]{content}` | One single element. Aliases: `\onerowfull`, `\onecolumneven`, and `\oneroweven`. | 1.0 |
| `\twocolumneven[layout options]{left content}{right content}` | Two columns of equal size. | 0.5:0.5 |
| `\twocolumnbigleft[layout options]{left content}{right content}` | Two columns, left bigger than right. | 0.66:0.33 |
| `\twocolumnbigright[layout options]{left content}{right content}` | Two columns, right bigger than left. | 0.33:0.66 |
| `\tworoweven[layout options]{top content}{bottom content}` | Two rows of equal size. | 0.5:0.5 |
| `\tworowbigtop[layout options]{top content}{bottom content}` | Two rows, top bigger than the bottom. | 0.66:0.33 |
| `\tworowbigbottom[layout options]{top content}{bottom content}` | Two rows, bottom bigger than the top. | 0.33:0.66 |
| `\threecolumneven[layout options]{left content}{middle content}{right content}` | Three columns of equal size. | 0.33:0.33:0.33 |
| `\threecolumnbigleft[layout options]{left content}{middle content}{right content}` | Three columns, left bigger than the middle and right. | 0.5:0.25:0.25 |
| `\threecolumnbigmiddle[layout options]{left content}{middle content}{right content}` | Three columns, middle bigger than the left and right. | 0.25:0.5:0.25 |
| `\threecolumnbigright[layout options]{left content}{middle content}{right content}` | Three columns, right bigger than the left and middle. | 0.25:0.25:0.5 |
| `\threeroweven[layout options]{top content}{middle content}{bottom content}` | Three rows of equal size. | 0.33:0.33:0.33 |
| |
| `\multicolumnlayout[layout options]{left fractional size}{left content}[middle fractional size][middle content][right fractional size][right content]` | Arbitrary sized 1--3 column layout. The fractional size arguments must each be between 0.0 and 1.0 and together sum to less than 1.0. |
| `\multirowlayout[layout options]{top fractional size}{top content}[middle fractional size][middle content][bottom fractional size][bottom content]` | Arbitrary sized 1--3 row layout. The fractional size arguments must each be between 0.0 and 1.0 and together sum to less than 1.0. |
```tex
\begin{frame}{Title}
  \onecolumnfull[layout options]%
  {%
    %Slide content
  }%
\end{frame}
```



### Layout Options
The `layout options` for the layout commands are:
| Option (default in bold) | Description |
| --- | --- |
| `alignedtop`, `raggedtop` | Align the top of all columns or make each column as tall as individually possible. Default set by package option. |
| `alignedbottom`, `raggedbottom` | Align the bottom of all columns or make each one as deep as individually possible. Default set by package option. | 
| **`decorations`**, `nodecorations` | Show decorations, e.g., title, logos, bio photos, slide number. |
| **`border`**, `noborder` | A blank-space border around the edges of the slide. |
| `gutter=LENGTH` | The size of the space between layout elements (i.e., columnes/rows). Default is the length `\latexpresents@gutter@column` defined in `latexpresents.sty`. |
| `nodebug`, `debug` | Debug the layout. Default set by package option. Especially useful for visualizing element (i.e., column/row) size in `\multicolumnlayout`/`\multirowlayout` or with `raggedtop` and `raggedbottom`. |



### Convenience Commands
Convenience commands exist to combine the one-element layout with media content.
These are technically both layout and content.
| Layout + Media | Description |
| --- | --- |
| `\imagecenter[caption][image options]{image file}[includegraphics options][layout options]` | Alias to `\onecolumnfull[layout options]{\image[caption][image options]{image file}[includegraphics options]}`. See [Images](https://github.com/robotic-esp/latexpresents#images). |
| `\pdfpagecenter[caption][image options]{page number}{pdf file}[includegraphics options][layout options]` | Alias to `\onecolumnfull[layout options]{\pdfpage[caption][image options]{page number}{pdf file}[includegraphics options]}`. See [Images](https://github.com/robotic-esp/latexpresents#images).|
| `\videocenter[caption][video options]{poster file}{video file}[layout options]` | Alias to `\onecolumnfull[layout options]{\video[caption][video options]{poster file}{video file}}`. See [Videos](https://github.com/robotic-esp/latexpresents#videos).|
```tex
\begin{frame}{Title}
  \imagecenter[caption]{image.png}%
\end{frame}
```



### Layout Dimensions
Layout commands provide information about the space available for content (i.e., the space inside of the slide borders and decorations) and the current element (i.e., column or row).
These LaTeX lengths can be useful for TikZ.
| Length | Description |
| --- | --- |
| `\contentposx` | The x coordinate of the top-left corner of the content area of a slide. |
| `\contentposy` | The y coordinate of the top-left corner of the content area of a slide. |
| `\contentwidth` | The width of the content area of a slide. |
| `\contentheight` | The height of the content area of a slide. |
| `\elementposx` | The x coordinate of the top-left corner of the current layout element. |
| `\elementposy` | The y coordinate of the top-left corner of the current layout element. |
| `\elementwidth` | The width of the current layout element. |
| `\elementheight` | The height of the current layout element. |





## Media
Commands exist to insert media (images and videos) to easily be as large as possible while maintaining their aspect ratio.

### Fullscreen Media
Commands exist to present images/videos in (faux) fullscreen.
These are technically both layout and content.
| Layout + Media | Description |
| --- | --- |
| `\fullimage[caption][caption options]{image file}[includegraphics options]` | A fullscreen image with an optional overlayed caption. |
| `\fullvideo[video options]{poster file}{video file}` | A fullscreen video. See [Video Options](https://github.com/robotic-esp/latexpresents#video-options) for `video options`. |
```tex
\begin{frame}
  \fullimage[caption]{image.png}%
\end{frame}
```



#### Caption Options
The `caption options` for `\fullimage`'s overlayed caption are:
| Option (default in bold) | Description |
| --- | --- |
| **`darkcaption`**, `lightcaption`| A light-coloured font on a dark background (`darkcaption`) or a dark-coloured font on a light background (`lightcaption`) as defined by the theme palette. |
| `captionposition=`**`southeast`**, `south`, `southwest`, `west`, `northwest`, `north`, `northeast`, `east` | Position of the caption. |
| `captiontext=COLOUR` | The colour of the caption text. Defaults to the colour set by `darkcaption`. |
| `captionbackground=COLOUR` | The colour of the caption background. Defaults to the colour set by `darkcaption`. |

Note that `darkcaption`/`lightcaption` are just presets for`captiontext=` and `captionbackground=` and that specifying  a preset and manual values is undefined behaviour.



### Images
Commands exist to insert images into an element (i.e., column/row) of a layout:
| Media | Description |
| --- | --- |
| `\image[caption][image options]{image file}[includegraphics options]` | An image with an optional caption that fills as much of its layout element as it can. |
| `\pdfpage[caption][image options]{page number}{pdf file}[includegraphics options]` | A version of `\image` with page selection. |
| `\imagestopbottom[top caption]{top image file}[bottom caption][image options]{bottom image file}[top includegraphics options][bottom includegraphics options]` | Two images stacked vertically within one layout element. |
| `\imagesleftright[left caption]{left image file}[right caption][image options]{right image file}[left includegraphics options][right includegraphics options]` | Two images stacked horizontally within one layout element. |
| `\pdfpagestopbottom[top caption]{top page number}{top pdf file}[bottom caption][image options]{bottom page number}{bottom pdf file}[top includegraphics options][bottom includegraphics options]` | A version of `\imagestopbottom` with page selection. |
| `\pdfpagesleftright[left caption]{left page number}{left pdf file}[right caption][image options]{right page number}{right pdf file}[left includegraphics options][right includegraphics options]` | A version of `\imagesleftright` with page selection. |
```tex
\begin{frame}{Title}
  \twocolumneven%
  {%
    My text content
  }%
  {%
    \image[Caption]{image.png}%
  }%
\end{frame}
```

#### Image Options
The same `image options` are available for the `\image` and \`pdfpage` families of commands:
| Option (default in bold) | Description |
| --- | --- |
| **`strictcaption`**, `underhangcaption` | Size the image with or without considering the height of its caption. Not considering the caption height can result in a larger image but the caption appearing outside the element's reserved space. This can be acceptable on an individual basis. |
| includegraphics options | The contents of this optional argument will be passed on to the underlying `\includegraphics` as arguments in addition to those used by the image command, i.e., `\includegraphics[...,options]{...}` |



### Videos
A command exists to insert videos into an element (i.e., column/row) of a layout:
| Media | Description |
| --- | --- |
| `\video[caption][video options]{poster file}{video file}` | A video with an optional caption that fills as much of its layout element as it can. The poster image should be the first frame of the video. |
```tex
\begin{frame}{Title}
  \twocolumnbigright%
  {%
    My text content
  }%
  {%
    \video[Caption]{image.png}{video.mp4}%
  }%
\end{frame}
```

Videos have been found to play best when they are encoded with a high number of keyframes as they otherwise can skip over the start.
Linux functions are provided in `cmds/` to (backup and) encode video files appropriately and create poster images, e.g., for all videos in a folder named `vids/`
```bash
cmds/encode_videos.sh vids/ && cmds/thumbnail_videos.sh vids/
```

#### Video Options
| Option (default in bold) | Description |
| --- | --- |
| **`autostart`**, `onclick` | Start the video automatically (`autostart`) or after clicking to advance the slide (`onclick`). Note that `onclick` actually just creates two identical slides, one with the poster image and one with an autoplaying video, with `\only`. |
| **`loop`**, `once` | Loop the video repeatedly or play it once. |
| **`noprogress`**, `progress` | Display video progress bar. |
| **`strictcaption`**, `underhangcaption` | See [Image Options](https://github.com/robotic-esp/latexpresents#image-options) |





## Content & Configuration
| Command | Description |
| --- | --- |
| `\title{text}` | Presentation title. Appears on title page. |
| `\name{text}` | Presenter name. Appears on title page. |
| `\group{text}` | Low-level institution. Appears on title page. |
| `\institute{text}` | High-level institution. Appears on title page. |
| `\date{text}` | Presentation date. Appears on title page. |
| `\closing{text}` | Closing text. Appears on thanks page. Defaults to 'Thank you'. |
| `\contact{text}` | Contact details (e.g., `\url{...}`, etc.). Appears on thanks page. Defaults to empty. |
| | |
| `\titlepage` | Manually insert a title slide in a frame. |
| `\thankspage[closing][contact]` | Insert a closing slide into a frame. The optional arguments "closing" and "contact" default to values set by `\closing{}` and `\contact{}`. |
| `\extraslides{tex}` | Effectively an appendix. Inserts a slide saying "Extra Slides" in front of the given frame environments and all those slides ARE NOT INCLUDED for the `handout` package option. |





## Slide Appearance
The package provides, modifies, and extends some LaTeX/Beaner commands for presentation appearance.

### Emphasis
Text can be highlighted or emphasized using an update to LaTeX's `\emph` and extensions to Beamer's `\alert`.
| Command | Description |
| --- | --- |
| `\emph{text}` | Emphasize text with an underline that is tighter to the font baseline and gives way to descenders. |
| `\alert{text}` | Emphasize text with bold and colour. Colour can defined by `\setXAlert` commands below. |
| `\alertBlue{text}` | Emphasize text with bold and a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\alertGreen{text}` | Emphasize text with bold and a green from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\alertYellow{text}` | Emphasize text with bold and a yellow from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\alertOrange{text}` | Emphasize text with bold and a orange from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\alertRed{text}` | Emphasize text with bold and a red from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\alertGray{text}` | Emphasize text with bold and a gray from the theme. The specific blue can/will change between `light` and `dark` presentations. |
```text
\begin{frame}{title}
  \onecolumnfull%
  {%
    \begin{itemize}
      \item \emph{Underlined}
      \item \alertBlue{Blue and bold}
      \item \alertRed{Red and bold}
    \end{itemize}
  }%
\end{frame}
```

#### Advanced alert control
Beamer uses alerts in other ways (e.g., overlay specifications), you can set the colour for these as well.
This will also change the colour of base `\alert` commands.
| Command | Descritpion |
| --- | --- |
| `\setBlueAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setGreenAlert` | Set future alert's to a green from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setYellowAlert` | Set future alert's to a yellow from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setOrangeAlert` | Set future alert's to a orange from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setRedAlert` | Set future alert's to a red from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setGrayAlert` | Set future alert's to a gray from the theme. The specific blue can/will change between `light` and `dark` presentations. |



### Slide Transitions
If your PDF reader supports automatic slide advancement and transition effects (e.g., pdfpc!), they can be specified in your LaTeX source:
| Command | Description |
| --- | --- |
| `\autoadvance{seconds}` | Auto advance out of the current slide after the specified number of seconds. |
| `\settransitioneffect{\effectcmd}` | Transition effect into the next slide. Must be specified before a layout command. |
| `\settransitiontime{seconds}` | Duration of the effect into the next slide in seconds. Must be specified before a layout command. |
| `\settransitionangle{angle}` | Angle of the effect into the next slide. Not meaningful for all transition effects. Must be specified before a layout command. |
```tex
\begin{frame}{title}
  \settransitioneffect{\transfade}%
  \settransitiontime{0.5}%
  \autoadvance{2}%
  %Layout command
\end{frame}
```

#### Transition Effects
The argument to `\settransitioneffect` is a base Beamer transition command.
Full details are available in the [Slide Transitions section of the Beamer documentation](http://mirrors.ctan.org/macros/latex/contrib/beamer/doc/beameruserguide.pdf), but include:
| Transition Effect |
| --- |
| `\transblindshorizontal` |
| `\transblindsvertical` |
| `\transboxin` |
| `\transboxout` |
| `\transcover` |
| `\transdissolve` |
| `\transfade` |
| `\transfly` |
| `\transglitter` |
| `\transpush` |
| `\transreplace` |
| `\transsplitverticalin` |
| `\transsplitverticalout` |
| `\transsplithorizontalin` |
| `\transsplithorizontalout` |
| `\transwipe` |





## Presentation Tools
The package provides and extends some LaTeX/Beamer commands to make presentation easier.

### Speaker Notes
The LaTeX source can contain speaker notes for each slide.
These are currently only included for the `pdfpc` package option as I don't know of an equivalent in Adobe Acrobat.
| Command | Description |
| --- | --- |
| `\say{notes}` | Notes to the speaker for the current slide. Markdown is supported in pdfpc. |
```tex
\begin{frame}{title}
  \onecolumnfull{...}%
  \say%
  {%
      - Introduce speaker's notes\\%
      - ...\\%
  }%
\end{frame}
```



### Incremental Slide Construction
Beamer provides a command to build multiple slides from the content in a single frame environment.
The command `\only<spec>{tex}` only compiles the `tex` code for slides specified by `spec` (e.g., `<1>`, `<2,4>`, `<3->`, `<1,4->`, etc.) and otherwise completely throws away the argument.
This is a powerful way to build incremental slides, but requires manually updating the `spec` of each `\only`.
Convenience functions are provided to automate this for simple cases from the order the content appears in the source using a counter:
| Command | Description |
| --- | --- |
| `\uncoverstep{tex}` | Show `tex` on a new slide and keep it for all following slides generated from this frame. Equivalent to `\only<counter->{tex}` |
| `\onlyonce{tex}` | Show `tex` on a  slide and then remove it for all following slides generated from this frame. Equivalent to `\only<counter>{tex}` |
```tex
\begin{frame}{title}
  \onecolumnfull%
  {%
    \begin{itemize}%
        \item First
        \uncoverstep{\item Second}%
        \uncoverstep{\item Third}%
    \end{itemize}%
  }%
\end{frame}
```
```tex
\begin{frame}{title}
  \onecolumnfull%
  {%
    \begin{itemize}%
      \onlyonce%
      {%
          \item Question?
      }%
      \onlyonce%
      {%
          \item Answer.
      }%
    \end{itemize}%
  }%
\end{frame}
```

#### Notes
- These commands currently only work _within_ a layout command (so do not put a layout in their argument)
- The two commands don't play the nicest together in the same frame.





## Slide Decorations
Slides are decorated by the layout commands with a slide number in the bottom right, optional title and optional subtitle in the top left (specified as per Beamer), a slide number in the bottom right, optional logos in the bottom left, and optional pictures of collaborators in the top right.

Note that if a title is present, then space is reserved in the title block for a subtitle even if one is not given.
This is to make all slides start at the same vertical position, regardless of their specific titling.
If no title is given, then no space is reserved for a title block.

```tex
\begin{frame}
  %Layout command
\end{frame}
\begin{frame}{title}
  %Layout command
\end{frame}
\begin{frame}{title}{subtitle}
  %Layout command
\end{frame}
```



### Logos
Slides can be decorated with logos either for the duration of the presentation (e.g., for the presenting organization) or for a select number of slides (e.g., a collaborating organization).
Logos appear left-to-right in the order added, and different logos can be specified for the title slide and content slides.
The logos of content slides appear in the bottom left.

Logos appear on all following slides, including the title and thanks slides but not fullscreen media, until reset.
See [Themes](https://github.com/robotic-esp/latexpresents#themes) for defining a common set of logos across multiple presentations.

| Commands | Description |
| --- | --- |
| `\addlogo[title logo]{slide logo}` | Add the provided logos. If the optional title logo is not given, then the slide logo is also used as a title logo. |
| `\addlightmodelogo[title logo]{slide logo}` | Add the provided logos only if in `light` mode. If the optional title logo is not given, then the slide logo is also used as a title logo. |
| `\adddarkmodelogo[title logo]{slide logo}` | Add the provided logos only if in `dark` mode. If the optional title logo is not given, then the slide logo is also used as a title logo. |
| `\resetlogos{}` | Reset logos to their saved state. |
| `\savelogos{}` | Save the current state of logos for future resets. |
| `\clearlogos{}` | Clear logos until reset. |
```tex
\addlogo{logo.png}
\begin{frame}{title}
  %Layout command. With logo.png
\end{frame}
\resetlogos{}% No other slides have logo.png
```



### Collaborators
Slides can be decorated in the top right with pictures of collaborators.
Collaborators appear right-to-left in the order added and appear on all following slides until cleared (except for title and thanks slides and fullscreen media).
| Command | Description |
| --- | --- |
| `\addperson{image file}` | Decorate all following slides with the provided image. |
| `\clearpeople{}` | Remove all collaborator decorations from following slides. |
```tex
\addperson{person.png}%
\begin{frame}{title}
  %Layout command. With person.png
\end{frame}
\clearpeople{}% No other slides have person.png
```





## Colours
The package defines the following colour variables from the theme files.
These colours will change in response to the `dark`/`light` package option and may be useful for TikZ.
See [Themes](https://github.com/robotic-esp/latexpresents#themes).
| Colour | Description |
| --- | --- |
| `BACKGROUND` | The colour of the slide backgrounds. |
| `TEXT` | The colour of the slide text. |
| `BLUE` | A blue |
| `GREEN` | A green |
| `YELLOW` | A yellow |
| `ORANGE` | An orange |
| `RED` | A red |
| `GRAY` | A gray |





## Themes
LaTeX Presents supports theme files so that organizations can define a common colour palette and logo arrangements for use across multiple people and presentations.
These theme files should define the organization's information, logos, and colour palette (as desired, defaults come from `theme_default.sty`) and can also include other settings that you would want every presentation to include in its preamble.

An example theme file for an organization with multiple groups:
```tex
% Affiliation:
\institute{Organization\\Conglomerate}% Possibly multiline organization name%
\closing{Thanks!}% 
\contact{\url{...}}% Contact details, e.g., website

% Logos
\addlightmodelogo[title logo]{foot logo}% First title and slide logos, for light mode
\adddarkmodelogo[title logo]{foot logo}% First title and slide logos, for dark mode
\addlightmodelogo{logo}% Second title and slide logo, for light mode
\adddarkmodelogo{logo}% Second title and slide logo, for dark mode

% Default appearance settings
\settransitioneffect{\transfade}

% Base colours
\colorlet{ThemePaletteLightBackground}{white}% Background colour in light mode
\colorlet{ThemePaletteDarkText}{black}% Text colour in light mode
\colorlet{ThemePaletteDarkBackground}{black}% Background colour in dark mode
\colorlet{ThemePaletteLightText}{white}% Text colour in dark mode

% Colour palette
\definecolor{ThemePaletteGray}{HTML}{...}% Used as GRAY
\definecolor{ThemePaletteBlue}{HTML}{...}% Used as BLUE in light mode
\definecolor{ThemePaletteGreen}{HTML}{...}% Used as GREEN in light mode
\definecolor{ThemePaletteOrange}{HTML}{...}% Used as ORANGE in light mode
\definecolor{ThemePaletteYellow}{HTML}{...}% Used YELLOW in light mode
\definecolor{ThemePaletteRed}{HTML}{...}% Used as RED in light mode
\definecolor{ThemePaletteLightBlue}{HTML}{...}% Used as BLUE in dark mode
\definecolor{ThemePaletteLightGreen}{HTML}{...}% Used as GREEN in dark mode
\definecolor{ThemePaletteLightOrange}{HTML}{...}% Used as ORANGE in dark mode
\definecolor{ThemePaletteLightYellow}{HTML}{...}% Used YELLOW in dark mode
\definecolor{ThemePaletteLightRed}{HTML}{...}% Used as RED in dark mode
```

The theme (with associated logo files) could then be used by individuals from different teams in their own presentations:
```tex
\documentclass[...]{beamer}
\usepackage[theme=file.sty]{latexpresents/latexpresents.sty}

\title{Presentation}
\name{Person}
\group{Team}
\date{\today}

\begin{document}
  %...
\end{document}
```
