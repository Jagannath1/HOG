#!/bin/bash
DIRECTORY="cases"
myreadset="myreadset"
convert_to_seconds () {
  local time=$1
  local minutes=${time%%m*}
  local seconds=${time#*m}
  seconds=${seconds%%s}
  echo $(bc <<< "$minutes*60+$seconds")
}
# average_time $test_file $no_of_times
average_time (){
	local time=0
    for ((i=1; i<=$2; i++)); do
		Y=`(time gt readjoiner prefilter -db "$1" -readset "$myreadset") 2>&1| grep sys`
		SYS_TIME=${Y:4}
		time=$(echo "$time + $(convert_to_seconds "$SYS_TIME")" | bc)
    	X=`(time ./FastAPSP "$1" -p 1) 2>&1| grep sys`
		SYS_TIME=${X:4}
		time=$(echo "$time + $(convert_to_seconds "$SYS_TIME")" | bc)
    done
	echo $(echo "scale=5; $time / $2" | bc)
}
>output_READJ.txt
for file in "$DIRECTORY"/*
do
	if [ -f "$file" ]
	  then
	    echo "Running test case $file..."
		echo "test case $file t=$(average_time $file 10)s" >> output_READJ.txt
	  fi
done