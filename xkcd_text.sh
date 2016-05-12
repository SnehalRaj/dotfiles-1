#!/bin/bash

num=$(cat ~/.current_comic)
num=${num%\.*}
num=${num##*/}
file=$num".dat"
values=$(cat ~/XKCD/data/$file | tail -n 1)
echo $values
