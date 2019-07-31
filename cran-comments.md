# General
This is the second submission. Only a few minor changes introduced (fixed typos, 
extended DESCRIPTION and README). No backward compatibility needs to be checked.

## Test environments 
* local Windows 8.1 64bit, R 3.4.3
* local macOS Mojave 10.14.5, R 3.5.1
* Ubuntu Trusty 14.04 (on travis-ci), R 3.6.0

## R CMD check results
There were no ERRORs or WARNINGs.

There was 1 NOTE:
* checking R code for possible problems ... NOTE
  parse_less: no visible binding for global variable 'output'
  Undefined global functions or variables:
    output
  
  V8 for R provides [a callback to R](https://cran.r-project.org/web/packages/V8/vignettes/v8_intro.html#callback-to-r)
  which is used to assign the output of the *parse_less* function to the 
  *output* variable. Since R does not know about it, NOTE is not relevant.
