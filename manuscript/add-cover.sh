#! /bin/bash
-e 
if ! [ -x "$(command -v sips)" ]; then
  echo 'Error: sips is not installed.' >&2
  exit 1
fi
if ! [ -x "$(command -v cpdf)" ]; then
  echo 'Error: cpdf is not installed. Visit http://community.coherentpdf.com  ' >&2
  exit 1
fi

sips -s format pdf --out images/title_page.pdf images/title_page.jpg

# install cpdf: http://community.coherentpdf.com 
cpdf -scale-to-fit a5portrait images/title_page.pdf -o images/title_page.pdf
cpdf images/title_page.pdf service-mesh-primer.pdf -o service-mesh-primer.pdf

# cleanup 
rm images/title_page.pdf