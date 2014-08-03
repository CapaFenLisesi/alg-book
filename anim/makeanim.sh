#!/bin/sh

#  makeanim.sh
#
#  Created by Jason Ermer on 08/01/14.
#

for f in linea lineb linec expoa expob expoc quada quadb quadc
do
    echo "Processing $f..."
    latex $f.tex
    dvips $f.dvi
    ps2pdf $f.ps
    echo
done

echo "Cleaning up..."
latexmk -c

echo "Done."

exit 0
