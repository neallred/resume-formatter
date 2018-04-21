#! /bin/sh
STYLE_PATH=${3:=""}
CONVERTED_STYLE_PATH="${STYLE_PATH%%.*}.css"
PAGE_MARGIN='12mm'

#convert sass to css
./node_modules/node-sass/bin/node-sass $STYLE_PATH $CONVERTED_STYLE_PATH

# stack exec pandoc $1 \
pandoc $1 \
   --from=markdown \
   --pdf-engine=wkhtmltopdf \
   --to=html5 \
   --output=$2 \
   --variable=margin-top:$PAGE_MARGIN \
   --variable=margin-right:$PAGE_MARGIN \
   --variable=margin-bottom:$PAGE_MARGIN \
   --variable=margin-left:$PAGE_MARGIN \
   --variable=papersize:letter 
#   --css ./$CONVERTED_STYLE_PATH

#clean up css
rm $CONVERTED_STYLE_PATH

# TODO: Remove <base></base><link rel="stylesheet"> hack (see https://github.com/wkhtmltopdf/wkhtmltopdf/issues/3627) made necessary by a regression (see https://github.com/jgm/pandoc/commit/c7e3c1ec1797d633c181e5701c94f4169b0e5471#diff-87268c8f8c723945b7a577f101eaff24L356)

# Example: 
# pandoc_build in/neallred.md out/neallred.pdf in/neallred.scss && zathura out/neallred.pdf
