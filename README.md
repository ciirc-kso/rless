
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rless <a href='https://github.com/ciirc-kso/rless'><img src='man/figures/logo.png' align="right" height="139" /></a>

[![CRAN
status](https://www.r-pkg.org/badges/version/rless)](https://cran.r-project.org/package=rless)[![Travis
build
status](https://travis-ci.org/ciirc-kso/rless.svg?branch=master)](https://travis-ci.org/ciirc-kso/rless)
[![](https://img.shields.io/badge/devel%20version-0.1.0-blue.svg)](https://github.com/ciirc-kso/rless)
[![](http://cranlogs.r-pkg.org/badges/grand-total/rless?color=blue)](https://cran.r-project.org/package=rless)

`rless` is R package providing CSS preprocessor features to R users.

It uses [LESS](http://lesscss.org/) language, which is an CSS extension
giving option to use variables, functions or using operators while
creating styles. Visit oficial [LESS](http://lesscss.org/) website for
more information about language specifics.

Provided LESS content is converted into CSS using
[V8](https://github.com/jeroen/V8) JavaScript engine.

## Installation

You can install the released version of rless from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rless")
```

or install the latest development build from Github:

``` r
# install.packages("devtools")
devtools::install_github("ciirc-kso/rless")
```

## Examples

The simplest way to use `rless` is to call `parse_less` function with
less content.

``` r
library(rless)

less <- "
@width: 10px;
@height: @width + 10px;

#header {
  width: @width;
  height: @height;
}
"

css <- parse_less(less)
cat(css)
#> #header {
#>   width: 10px;
#>   height: 20px;
#> }
```

``` r
less <- "
.bordered {
  border-top: dotted 1px black;
  border-bottom: solid 2px black;
}

#menu a {
  color: #111;
  .bordered();
}

.post a {
  color: red;
  .bordered();
}
"

css <- parse_less(less)
cat(css)
#> .bordered {
#>   border-top: dotted 1px black;
#>   border-bottom: solid 2px black;
#> }
#> #menu a {
#>   color: #111;
#>   border-top: dotted 1px black;
#>   border-bottom: solid 2px black;
#> }
#> .post a {
#>   color: red;
#>   border-top: dotted 1px black;
#>   border-bottom: solid 2px black;
#> }
```

We strongly recommend to visit official
[guide](http://lesscss.org/features/) to grasp the full power of the
LESS preprocessor tool.
