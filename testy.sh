#!/bin/bash
DIRECTORIES=("equal_sze/K-fixed" "equal_sze/N-fixed" "not_equal_sze/K-fixed" "not_equal_sze/N-fixed")
# DIRECTORY1="equal_sze/K-fixed"
# DIRECTORY2="equal_sze/N-fixed"
# DIRECTORY3="not_equal_sze/K-fixed"
# DIRECTORY4="not_equal_sze/N-fixed"
N=(1000000 2000000 3000000 4000000 5000000 6000000)
# N1=1000000
# N2=2000000
# N3=3000000
# N4=4000000
# N5=5000000
# N6=6000000
K=(1000 2000 3000 4000 5000 6000)

# K1=1000
# K2=2000
# K3=3000
# K4=4000
# K5=5000
# K6=6000
const=100
convert_to_seconds () {
  local time=$1
  local minutes=${time%%m*}
  local seconds=${time#*m}
  seconds=${seconds%%s}
  echo $(bc <<< "$minutes*60+$seconds")
}
g++ main2.cpp
>output.txt
for n_value in ${N[@]}
do
    time=0
    for file in "cases/${DIRECTORIES[0]}/N_$n_value"/* 
    do
        if [ -f "$file" ]
            then 
                echo "$file"
                X=`(time ./a.out "$file") 2>&1| grep sys`
                SYS_TIME=${X:4}
                time=$(echo "$time + $(convert_to_seconds "$SYS_TIME")" | bc)
        fi
    done
    echo "N=$n_value K=${K[0]} t= $(echo "scale=5; $time / $const" | bc)" >> output.txt
done
cp output.txt output/"${DIRECTORIES[0]}"/result.txt

>output.txt
for k_value in ${K[@]}
do
    time=0
    for file in "cases/${DIRECTORIES[1]}/K_$k_value"/* 
    do
        if [ -f "$file" ]
            then 
                echo "$file"
                X=`(time ./a.out "$file") 2>&1| grep sys`
                SYS_TIME=${X:4}
                time=$(echo "$time + $(convert_to_seconds "$SYS_TIME")" | bc)
        fi
    done
    echo "N=${N[5]} K=$k_value t= $(echo "scale=5; $time / $const" | bc)" >> output.txt
done
cp output.txt output/"${DIRECTORIES[1]}"/result.txt


>output.txt
for n_value in ${N[@]}
do
    time=0
    for file in "cases/${DIRECTORIES[2]}/N_$n_value"/* 
    do
        if [ -f "$file" ]
            then 
                echo "$file"
                X=`(time ./a.out "$file") 2>&1| grep sys`
                SYS_TIME=${X:4}
                time=$(echo "$time + $(convert_to_seconds "$SYS_TIME")" | bc)
        fi
    done
    echo "N=$n_value K=${K[0]} t= $(echo "scale=5; $time / $const" | bc)" >> output.txt
done
cp output.txt output/"${DIRECTORIES[2]}"/result.txt

>output.txt
for k_value in ${K[@]}
do
    time=0
    for file in "cases/${DIRECTORIES[3]}/K_$k_value"/* 
    do
        if [ -f "$file" ]
            then 
                echo "$file"
                X=`(time ./a.out "$file") 2>&1| grep sys`
                SYS_TIME=${X:4}
                time=$(echo "$time + $(convert_to_seconds "$SYS_TIME")" | bc)
        fi
    done
    echo "N=${N[5]} K=$k_value t= $(echo "scale=5; $time / $const" | bc)" >> output.txt
done
cp output.txt output/"${DIRECTORIES[3]}"/result.txt
