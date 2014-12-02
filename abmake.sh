#!/bin/sh

#  algmake.sh
#
#
#  Created by Jason Ermer on 11/27/14.
#

# Get time as a UNIX timestamp
T="$(date +%s)"

# Reset in case getopts has been used previously in the shell.
OPTIND=1

# Initialize our temporary variables.
cleanup=0
makebook=0
makechap=0

# Parse command line options.
while getopts ":bcx" opt; do
    case $opt in

    b)
        makebook=1
        ;;

    c)
        makechap=1
        ;;

    x)
        cleanup=1
        ;;

    \?)
        echo "Invalid option: -$OPTARG">&2
        exit 0
        ;;
    esac
done

#
# If both -b and -c options are absent, interpret this as a
#
if [ "$makebook" == 0 ] && [ "$makechap" == 0 ] && [ "$cleanup" == 0 ]; then
    makebook=1
    makechap=1
fi

#
# Generate the whole-book PDF
#
if [ $makebook == 1 ]; then
    echo "Buildiing omnibus PDF...">&2
    latexmk -pdf algebranomicon
fi

#
# Generate chapter PDFs
#
if [ $makechap == 1 ]; then
    echo "Buildiing chapter PDFs...">&2

    for lap in 1 2
    do
        for i in ch*.tex
        do
            j=${i%.tex}
            #pdflatex -jobname=the$j "\def\indchap{1} \includeonly{$j, glossary}\input{algebranomicon}";
            pdflatex -jobname=the$j "\def\indchap{1}\includeonly{$j}\input{algebranomicon}";
            #pdflatex -jobname=the$j "\includeonly{$j, glossary}\input{algebranomicon}";
            #pdflatex -jobname=the$j "\includeonly{$j}\input{algebranomicon}";
            #echo ${i:2:2};
            mv the$j.pdf algebranomicon_${i:2:2}.pdf;
        done
    done
fi

#
# Run cleanup, if the -x option was specified
#
if [ $cleanup == 1 ]; then
    echo "Cleaning up...">&2
    latexmk -c
    rm the*.*
fi

T="$(($(date +%s)-T))"
echo "Time in seconds: ${T}"
