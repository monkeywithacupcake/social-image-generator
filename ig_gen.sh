#!/bin/zsh
# Makes A Series of Images based on two sets of arrays in Square and Rectangle shape
# Requirements: ImageMagick

# takes an array of backgrounds
# reads a list of strings

# assumes existence of a directory with /images /logo and /backgrounds



echo "Starting InstaMagick Creation of Images"
theDir=${1:-"${HOME}/social-image-generator/example-dir"}
echo "$theDir"
FILES=$theDir/backgrounds/*
# create the temporary correct sized backgrounds
mkdir $theDir/tmp

i=0
for f in $FILES
  do
    let i++
    convert $f -filter lanczos -resize 1080x1080^ -gravity Center -crop 1080x1080+0+0 +repage \
    -gravity South  $theDir/logo.png -background transparent -extent 1080x1080\
    -layers merge  $theDir/tmp/$i.jpg
    convert $f -filter lanczos -resize 1080x540^ -gravity Center -crop 1080x540+0+0 +repage \
    -gravity Southeast  $theDir/logo.png -background transparent -extent 1080x540\
    -layers merge  $theDir/tmp/tw$i.jpg
  done
echo "i is now $i"

# for each string, make a file
STRINGS=("some words" "more words" "you can do a longer bit of words and it will be smaller but still fit" "if \n you \n want")

mkdir $theDir/output
mkdir $theDir/twitter
j=1
k=1

# -fill and -stroke colors are for text color

for lbl in "${STRINGS[@]}"
  do
    convert $theDir/tmp/$j.jpg +repage \
     -size 800x600  -fill '#212121' -background None -strokewidth 1 -stroke '#212121' \
     -font RalewayBk -gravity center caption:"$lbl" +repage \
     -gravity Center  -composite -strip  $theDir/output/$k.jpg

    convert $theDir/tmp/tw$j.jpg +repage \
     -size 800x400  -fill '#212121' -background None \
     -font RalewayBk -gravity center caption:"$lbl" +repage \
     -gravity Center  -composite -strip  $theDir/twitter/$k.jpg
    let j++
    let k++
    if [[ $j -gt $i ]]; then
        j=1
    fi
  done

# now get an image to go between the text
echo "k is now $k"
IMAGES=$theDir/images/*
n=0
for m in $IMAGES
  do
    let n++
    convert $m -auto-orient -filter lanczos -resize 1080x1080^ -gravity Center -crop 1080x1080+0+0  \
          -level 0,75% +repage \
          -size 1080x1080  xc:"#2196F3"  -gravity Center -alpha on \
          -compose blend  -define compose:args=20  -composite     \
          $theDir/logo.png -gravity South -compose over -composite -strip \
          $theDir/output/"$n"a.jpg
    convert $m -auto-orient -filter lanczos -resize 1080x540^ -gravity Center -crop 1080x540+0+0  \
          -level 0,75% +repage \
          -size 1080x540  xc:"#2196F3"  -gravity Center -alpha on \
          -compose blend  -define compose:args=20  -composite     \
          $theDir/logo.png -gravity Southeast -compose over -composite -strip \
          $theDir/twitter/"$n"a.jpg
  done
# create a contact sheet with all of them
montage -tile 8x -geometry +0+0 $theDir/output/* $theDir/big.jpg

rm -r $theDir/tmp/


