Installation
============

This "project" has many dependencies. You will need:
1. node-sass from npm (for scss support. If only regular css needed, this can be omitted)
2. latex,
3. wkhtmltopdf,
4. pandoc,

Usage
=====

To format a markdown resume as a pdf, use `./pandoc_build PATH_TO_SOURCE PATH_TO_DESTINATION PATH_TO_CSS`

If straight markdown is not sufficient, raw html can be used with some limitations:
1. Markdown inside raw html is not allowed.
2. Sometimes deeply nested html does not get properly interpreted if indented properly. Try flattening indentation.

CSS has some limitations:
1. Font support is OS/machine specific.
2. Font only changes when specified in the source markdown resume, not when specified in the style sheet.
