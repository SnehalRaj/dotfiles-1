#!/bin/zsh
# Battery level
level=$(acpi | grep -o "[0-9]*%" | sed 's/%$//')
# No. of full bars
full=$(( ($level+10)/20 ))
# No. of empty bars
empty=$(( 5 - $full))
# Normal uncolored output
output=''
for ((i = 0; i < $full; i++)); do
  output=$output'▸'
done
for ((i = 0; i < $empty; i++)); do
  output=$output'▹'
done
echo $output
