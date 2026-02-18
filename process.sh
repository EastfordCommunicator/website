#!/usr/bin/env bash

read -r -p "Type volume: " volume
read -r -p "Type issue: " issue

echo "volume $volume, issue $issue"

mkdir "./articles/$volume/$issue/"
echo "created ./articles/$volume/$issue/"

cd "./_docx/$volume-$issue/"

find -iname "*.docx" -execdir pandoc \{} -t markdown -o "{}.md" \;

echo "files converted"

mv ./*.md ../../articles/$volume/$issue/

mv ./*/*.md ../../articles/$volume/$issue/

echo "files copied"

mmv -c './*/* *.jpg' "../../assets/images/$volume-$issue#l2-#l3.jpg"

mmv -c './*/* *.png' "../../assets/images/$volume-$issue#l2-#l3.png"

echo "images copied"

echo "files not copied; do not meet selectors!--"

find -not -iname "*.jpg" -and -not -iname "*.png" -and -not -iname "*.docx" -and -not -type d

cd "../../"

echo "finished"