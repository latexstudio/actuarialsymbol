> **For GitHub display**
>
> This is the `README.md` file used in the LaTeX package
> `actuarialsymbol`.
>
> The package is distributed through
> [CTAN](https://www.ctan.org/pkg/actuarialsymbol).

# actuarialsymbol

Package `actuarialsymbol` provides commands to compose
actuarial symbols of life contingencies and financial mathematics
characterized by subscripts and superscripts on both sides of a
principal symbol. The package also features commands to easily and
consistently position precedence numbers above or below statuses
in symbols for multiple lives contracts.

Since the actuarial notation can get quite involved. the package
defines a number of shortcut macros to ease entry of the most common
elements. Appendix A of the package documentation lists the commands
to typeset a large selection of symbols of life contingencies.

## Licence

LaTeX Project Public License, version 1.3c or (at your option) any
later version.

## Authors

David Beauchemin <david.beauchemin.5@ulaval.ca>, Vincent Goulet
<vincent.goulet@act.ulaval.ca>

## Dependency

This package requires `actuarialangle` (version v2.0 dated 2017/04/10
or above is needed to typeset the documentation).

## Installation

The package is part of TeX Live and MiKTeX. If it is not already
installed on your system, run `actuarialsymbol.dtx` through LaTeX with,
for example,

    pdflatex actuarialsymbol.dtx

and copy `actuarialsymbol.sty` where LaTeX can find it.

## Documentation

File `actuarialsymbol.pdf` contains the complete documentation of the
package. If needed, the documentation can be generated from the
sources using the following commands:

    pdflatex actuarialsymbol.dtx
    makeindex -s gglo.ist -o actuarialsymbol.gls actuarialsymbol.glo
    pdflatex actuarialsymbol.dtx

## Version history

See the documentation.
