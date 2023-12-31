# LaTeX Presents 
This is a LaTeX presentation package that wraps Beamer with the goal of being:
 - Media friendly (images and video)
 - Quick and easy to use
 - Visually clean and simple

The excellent [pdfpc](https://pdfpc.github.io/) program is highly recommended to present the resulting PDFs.

The package uses the Beamer `frame` environment and defines [layouts](https://github.com/robotic-esp/latexpresents#layouts) for use within the frame.
Each element (i.e., row or column) of a layout can be filled with any LaTeX content, e.g., lists, math, TikZ, [images](https://github.com/robotic-esp/latexpresents#images), [videos](https://github.com/robotic-esp/latexpresents#videos), etc.
Most slides will have a hierarchy like:
```tex
\begin{frame}{title}
  %Layout command
    %Content
\end{frame}
```





## Installation
This package should be checked out as a subfolder to your LaTeX project named `latexpresents`:
```bash
git clone https://github.com/robotic-esp/latexpresents.git latexpresents
```

This package is then used in your LaTeX project directly as cloned from the repository.
Your LaTeX document's preamble should look like:
```tex
\documentclass[aspectratio=169,t,12pt]{beamer}
% Aspect ratios: 169 (16:9), 1610 (16:10), 149 (14:9), 32 (3:2), 141 (1.41:1), 43 (4:3), 54 (5:4)

\usepackage[package options]{latexpresents/latexpresents.sty}

%...

\begin{document}
%...
\end{document}
```
LaTeXPresents requires the Beamer options `t` and `12pt` and is mainly developed/tested on the `16:9` aspect ratio, but the other ratios will work (in theory).



### Package Options
The package includes the following options:
| Option (default in bold) | Description |
| --- | --- |
| `theme=PATH/TO/FILE` | Path to user-provided theme file that defines a colour palette and logos. The user-provided theme is applied on top of the default (logo-free) theme, so that a complete palette is always defined. |
| **`light`**, `dark` | Light or dark presentation. |
| **`pdfpc`**, `adobe` | Target PDF reader. Affects speaker notes and how videos are embedded and other things as necessary. Presentation in Linux currently requires pdfpc. Presentation in Windows or MacOS may target either pdfpc or Adobe Acrobat. Please see note. |
| **`present`**, `handout` | Compile file as a presentation or as a handout. Handouts simplify transitions and videos and do not include any extra slides. |
| **`videos`**, `novideos` | Compile file with videos or with replacement images. Combine `novideos` with `handout` to make a lightweight handout. |
| **`pagenumbers`**, `nonumbers` | Include slide numbers. |
| **`alignedtop`**, `raggedtop` | Set the global layout default. See [Layout Options](https://github.com/robotic-esp/latexpresents#layout-options) |
| `alignedbottom`, **`raggedbottom`** | Set the global layout default. See [Layout Options](https://github.com/robotic-esp/latexpresents#layout-options) |
| **`titlepage`**, `notitlepage` | Automatic title slide inclusion. |
| `debug`, **`nodebug`** | Enable global debugging. This includes layout debugging. |

#### Note
PDFs created for pdfpc currently embed videos with `\href` instead of `\movie`.
This allows pdfpc to avoid a bug in the open-source low-level PDF library that prevents autoplay but means that
 1. the videos are not actually embedded in the file and must be in the same place at presentation as during compile, and
 2. PDFs compiled for pdfpc will not work in any other PDF viewer (specifically, the videos won't).

This behaviour will change when the updated version of the library appears in enough versions of Ubuntu.

PDFs created for Adobe Acrobat may work in other PDF viewers, especially on Windows and MacOS.





## Layouts
Every frame must contain a layout command.
The available layout commands are:
| Layout | Description |
| --- | --- |
| `\onecolumnfull[layout options]{content}` | One single element. Aliases: `\onerowfull`, `\onecolumneven`, and `\oneroweven`. |
| `\twocolumneven[layout options]{left content}{right content}` | Two columns of equal size. |
| `\twocolumnbigleft[layout options]{left content}{right content}` | Two columns, left bigger than right. |
| `\twocolumnbigright[layout options]{left content}{right content}` | Two columns, right bigger than left. |
| `\tworoweven[layout options]{top content}{bottom content}` | Two rows of equal size. |
| `\tworowbigtop[layout options]{top content}{bottom content}` | Two rows, top bigger than the bottom. |
| `\tworowbigbottom[layout options]{top content}{bottom content}` | Two rows, bottom bigger than the top. |
| `\threecolumneven[layout options]{left content}{middle content}{right content}` | Three columns of equal size. |
| `\threecolumnbigleft[layout options]{left content}{middle content}{right content}` | Three columns, left bigger than the middle and right. |
| `\threecolumnbigmiddle[layout options]{left content}{middle content}{right content}` | Three columns, middle bigger than the left and right. |
| `\threecolumnbigright[layout options]{left content}{middle content}{right content}` | Three columns, right bigger than the left and middle. |
| `\threeroweven[layout options]{top content}{middle content}{bottom content}` | Three rows of equal size. |
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
| `gutter=LENGTH` | The size of the space between columnes/rows. Default is the length `\latexpresents@gutter@column` defined in `latexpresents.sty`. |
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

Note that `darkcaption`/`lightcaption` are directly preset combinations of `captiontext=` and `captionbackground=` and that specifying both is undefined behaviour.



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
| **`strictcaption`**, `underhangcaption` | Size the image with or without considering the height of its caption. Not considering the caption height can result in a larger image but the caption appearing outside the element's reserved boundaries. This can be acceptable on an individual basis. |
| includegraphics options | The contents of this optional argument will be passed on to the underlying `\includegraphics` as extra arguments to those used by the image command, i.e., `\includegraphics[...,options]{...}` |



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

Videos play best when they are encoded with a high number of keyframes, otherwise they often skip the start.
Linux functions are provided in `cmds/` to encode video files appropriately and create poster images, e.g., for all videos in a folder named `vids/`
```bash
cmds/encode_videos.sh vids/ && cmds/thumbnail_videos.sh vids/
```

#### Video Options
| Option (default in bold) | Description |
| --- | --- |
| **`autostart`**, `onclick` | Start the video automatically or after clicking to advance the slide. Note that `onclick` works by creating two identical slides, one with the poster image and one with an autoplaying video. |
| **`loop`**, `once` | Loop the video repeatedly or play it once. |
| **`noprogress`**, `progress` | Display video progress bar. |
| **`strictcaption`**, `underhangcaption` | See [Image Options](https://github.com/robotic-esp/latexpresents#image-options) |





## Content Configuration
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
| '\extraslides{tex}' | Effectively an appendix. Inserts a slide saying "Extra Slides" in front of the given frame environments and all those slides ARE NOT INCLUDED when the package option `handout` is set. |





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
Beamer uses alears in other ways (e.g., overlay specifications), you can set the colour for these as well.
This will also change the colour of base `\alert` commands.
| Command | Descritpion |
| --- | --- |
| `\setBlueAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setGreenAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setYellowAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setOrangeAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setRedAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |
| `\setGrayAlert` | Set future alert's to a blue from the theme. The specific blue can/will change between `light` and `dark` presentations. |



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
These are currently only include if the package option `pdfpc` is specified as I don't know of an equivalent in Adobe Acrobat.
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
Beamer provids a really powerful command that allows for multiple slides to be built from the content in a single frame environment.
The command `\only<spec>{tex}` only compiles the `tex` code for slides specified by `spec` (e.g., `<1>`, `<2,4>`, `<3->`, `<1,4->`, etc.) and otherwise completely throws away the argument.
This is a powerful way to build incremental slides, but requires manually updating the `spec` of each `\only`.
Convenience functions are provided to automate this from the order the content appears in the source using a counter:
| Command | Description |
| --- | --- |
| `\uncoverstep{tex}` | Show `tex` on a new slide and keep for all following slides generated from this frame. Equivalent to `\only<counter->{tex}` |
| `\onlyonce{tex}` | Show `tex` on a new slide and then remove for all following slides generated from this frame. Equivalent to `\only<counter>{tex}` |
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
      \item Question?
      \onlyonce%
      {%
        \item Answer
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
`\adddarkmodelogo[]{}`
`\addlightmodelogo[]{}`
`\addlogo[]{}`
`\savelogos{}`
`\resetlogos{}`
`\clearlogos{}`
`\addtitlelogo{}` `\addfootlogo{}`
`\savetitlelogo{}` `\savefootlogo{}`
`\resettitlelogos{}` `\resetfootlogos{}`
`\cleartitlelogos{}` `\clearfootlogos{}`

### Collaborators
Slides can be decorated in the top right with pictures of collaborators.
| Command | Description |
| --- | --- |
| `\addperson{image file}` | Decorate all following slides with the provided image. |
| `\clearpeople{}` | Remove all collaborator decorations from following slides. |
```tex
\addperson{image.png}%
\begin{frame}{title}
  %Layout command
    %Content command
\end{frame}
\clearpeople{}%
```


## Theme
LaTeX Presents supports theme files so that organizations can define common colour palettes and logo arrangements.
