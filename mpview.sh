#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: mpview <mp_file> ">&2
    exit 1;
fi

echo "$1" | grep '\.mp' -q

if [ $? -eq 0 ]; then
    mpfile=`echo "$1" | sed -e 's/\(.*\)\.mp/\1/'`;
else
    mpfile="$1";
fi

if [ -f "$mpfile".mp ]; then
    mpost -interaction=nonstopmode "$mpfile";
else
    echo "error: cannot find input file: $mpfile.mp" >&2;
    exit 1;
fi

mppre="$mpfile"_preview

echo "\documentclass{article}
\usepackage{graphicx}
\usepackage[margin=1cm]{geometry}
\pagestyle{empty}
\begin{document}
\centering " > a.tex

name=`grep -o "\bfig.[0-9]\b" $mpfile.log`
echo "the figure file is $name"

echo "\includegraphics{$name}">>a.tex

echo "\end{document}" >> a.tex

latex a.tex
dvips a.dvi
ps2pdf a.ps a.pdf
rm fig.log  a.log a.aux
rm a.tex a.dvi $mpfile.log a.ps
rm $name
open a.pdf
