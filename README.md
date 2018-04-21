Installation
============

This "project" has many dependencies. You will need:
1. node-sass from npm (project install, optional for scss support)
2. wkhtmltopdf (system install)
3. pandoc (system install)

Usage
=====

To format a markdown resume as a pdf, use `./pandoc_build PATH_TO_SOURCE PATH_TO_DESTINATION PATH_TO_CSS`

If straight markdown is not sufficient, raw html can be used with some limitations:
1. Markdown inside raw html is not allowed.
2. Sometimes deeply nested html does not get properly interpreted if indented properly. Try flattening indentation.
    - This may no longer be an issue in Pandoc 2 (see https://pandoc.org/releases.html#pandoc-2.0-29-oct-2017).

CSS has some limitations:
1. Font support is OS/machine specific.
2. Font only changes when specified in the source markdown resume, not when specified in the style sheet.
