#!/bin/bash

num=$(cat ~/.current_comic)
num=${num%\.*}
num=${num##*/}
file=$num".dat"
values=$(cat ~/XKCD/data/$file | head -n 1)
echo $values
