#!/bin/bash

for i in {1..30}; do
  folder="./exp_nanjing$i"
  if [ -d "$folder" ]; then
    cd "$folder"
    gfortran main.f90 -o a.out &&
    pwd
    if [ -f "a.out" ]; then
      log="output_file$i.txt"
      ./a.out >> "$log" &
      echo "Started a.out in $folder"
    else
      echo "a.out not found in $folder"
    fi
    cd ..
  else
    echo "$folder not found"
  fi
done
