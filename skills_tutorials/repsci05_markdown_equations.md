# Equations in LaTeX, markdown and GitHub
LaTeX is the standard for writing and typesetting mathematical equations in documents. It is used extensively in the mathematical and technical community. Equations are typed in plain text, like this:

```
y_{i} = \beta_0 + \beta_1 x
```

and they will be rendered like this:

![y\_{i} = \\beta\_0 + \\beta\_1
x](https://latex.codecogs.com/png.latex?y_%7Bi%7D%20%3D%20%5Cbeta_0%20%2B%20%5Cbeta_1%20x
"y_{i} = \\beta_0 + \\beta_1 x") 

It's mostly straightforward to write an equation in LaTeX. You just have to know the symbol syntax. Here are some references:

* [Symbol cheatsheet](https://kapeli.com/cheat_sheets/LaTeX_Math_Symbols.docset/Contents/Resources/Documents/index)
* [Wikibook](https://en.wikibooks.org/wiki/LaTeX/Mathematics) but ignore the first section. The most relevant sections are from [symbols](https://en.wikibooks.org/wiki/LaTeX/Mathematics#Symbols) to [brackets](https://en.wikibooks.org/wiki/LaTeX/Mathematics#Brackets,_braces_and_delimiters).
* Find a symbol [by drawing it](http://detexify.kirelabs.org/classify.html)
* [WYSWIG equation editor](https://editor.codecogs.com/) that will output LaTeX syntax from a graphical menu of symbols.

You can enter equations using LaTeX in Microsoft Word and Google Docs, so this is a universal skill.

#### Equations in markdown and GitHub

You can write equations using LaTeX syntax that will render beautifully in many markdown applications and websites that are [MathJax](https://www.mathjax.org/) configured. Unfortunately equations are painful in GitHub markdown as GitHub doesn't natively render them. As a workaround for GitHub markdown, add the following to your R script or Rmarkdown:

```
---
output:
    github_document:
        pandoc_args: --webtex
---
```
This workaround substitutes pictures for web-rendered equations.

In markdown you need to surround equations with `$ ... $` for inline equations (small symbols), or with `$$ ... $$` for "display" style (separate paragraph, centered, large symbols).

For example, this LaTeX syntax:
```
$$y_i \sim \mathrm{Normal}(\mu_i,\sigma)$$
```
produces this:

$$y_i \sim \mathrm{Normal}(\mu_i,\sigma)$$

The above won't display an equation on GitHub (just the LaTeX) - you have to view it in a markdown editor capable of showing equations.

The following is produced after knitting from Rmarkdown with the above YAML hack and displays an equation on the GitHub webpage:

![y\_i \\sim
\\mathrm{Normal}(\\mu\_i,\\sigma)](https://latex.codecogs.com/png.latex?y_i%20%5Csim%20%5Cmathrm%7BNormal%7D%28%5Cmu_i%2C%5Csigma%29
"y_i \\sim \\mathrm{Normal}(\\mu_i,\\sigma)")

Out of the box, RStudio should be capable of displaying typeset equations from the LaTeX text. However, to display equations on your own computer within a different markdown editor, or to print to pdf, you may need to also install [pandoc](https://pandoc.org/installing.html) or a LaTeX engine (e.g. [miktex](https://miktex.org/)).