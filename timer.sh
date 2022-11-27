#!/bin/bash

total_seconds=0
for i in $*
do
  case $i in
    -s=*|--seconds=*)
    total_seconds=$(($total_seconds + ${i#*=}))
    ;;
    -m=*|--minutes=*)
    total_seconds=$(($total_seconds + 60 * ${i#*=}))
    ;;
    -h=*|--hours=*)
    total_seconds=$(($total_seconds + 3600 * ${i#*=}))
  esac
done

for (( remaining_seconds=$total_seconds; remaining_seconds>0; remaining_seconds-- ));
do
  hours=$((remaining_seconds / 3600))
  minutes=$(((remaining_seconds / 60) % 60))
  seconds=$((remaining_seconds % 60))
  printf "\rTimer %02d:%02d:%02d" $hours $minutes $seconds
  sleep 1
done
echo -e "\rTimer 00:00:00"
kdialog --passivepopup "Timer finished!" --title "Timer finished!"
