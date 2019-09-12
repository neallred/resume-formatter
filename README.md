# resume-stuff

## Setup

This "project" depends on:
1. wkhtmltopdf (system install)
1. [stack](haskellstack.org) and dependencies installed by `stack build`

Using your Operating System's package manager, install wkhtmltopdf. For example, on debian,
```
sudo apt update
sudo apt install wkhtmltopdf
```

If `stack` is not already installed, install it with

```
curl -sSL https://get.haskellstack.org/| sh
```

Once stack is installed, run

```
stack build
```

to build the executable.

## Usage

To generate the resume, run

```
stack exec resume-formatter
```

Changes to the resume content can be achieved by editing the markdown file and rerunning the executable. Changes to the stylesheet require a recompile via `stack build`

## Advanced usage
If straight markdown is not sufficient, raw html can be used with some limitations:
1. Markdown inside raw html is not allowed.
1. Sometimes deeply nested html does not get properly interpreted if indented properly. Try flattening indentation.
    - This may no longer be an issue in Pandoc 2 (see https://pandoc.org/releases.html#pandoc-2.0-29-oct-2017).

## Notes
CSS has some limitations:
1. Font support is OS/machine specific.
1. Font only changes when specified in the source markdown resume, not when specified in the style sheet. (TODO: Is that still true?)
