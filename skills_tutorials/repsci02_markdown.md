# Markdown basics
A markdown document is plain text but includes some simple formatting markup that can be interpreted to display the file in different styles for components such as headings, lists, URLs, code blocks, etc. 
* Generic Markdown
  * [Getting started](https://www.markdownguide.org/getting-started/) - including how it works
* Github flavored markdown
  * [Basics](https://help.github.com/en/github/writing-on-github/basic-writing-and-formatting-syntax) - including styling, lists, links
  * [Advanced](https://help.github.com/en/github/writing-on-github/working-with-advanced-formatting) - including tables, code blocks

Markdown documents have the file extension `.md`. We will later also look at Rmarkdown, which is a flavor of markdown specific to R.

### Editors

You can use any text editor to create a markdown document, or even RStudio, but it's good to have a text editor that can display the rendered markdown in real time. There are so many options out there it's really down to personal preference. Try a bunch out. I would prefer a simple editor that opens instantly (e.g. [Electron](https://en.wikipedia.org/wiki/Electron_(software_framework)) apps often open very slowly), is open source, and works on Windows, Mac, and Linux but I haven't found one yet with all of these attributes. My current favorite is [Typora](https://typora.io/) (free but not open source). It doesn't properly display markdown rendered by `knitr` but I rarely want to view these files locally anyway. [Mark text](https://marktext.app/) (Electron) is similar and open source but it's very new so I can't vouch for it yet.

Another option is the open-source [Atom](https://atom.io/) developed by GitHub with three packages:

* Install packages
  * file > settings > install
* markdown-preview-plus
  * file > settings > packages > markdown-preview-plus > settings
  * enable all preview position sync options
  * enable math rendering
* atom-language-r
* language-markdown

Atom is the original Electron app and it takes a long time to start up, which drives me nuts!

I have heard a lot of people like the open-source [VS code](https://code.visualstudio.com/) (also Electron) from Microsoft but I haven't tried it. You would need to research how to best set it up for markdown.

Let me know if you find a text editor for markdown that you like!

