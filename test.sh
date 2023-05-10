#!/bin/bash
convert_to_seconds () {
  local time=$1
  local minutes=${time%%m*}
  local seconds=${time#*m}
  seconds=${seconds%%s}
  echo $(bc <<< "$minutes*60+$seconds")
}
const=20
k=1000
n=1000000
increment=100000
incrementk=10000
max=1000000
maxk=100000
time_hog=0
time_fas=0
time_sof=0
time_read=0
>input.txt
>input.fa
g++ gen_test.cpp
cd HOG-main
g++ main2.cpp
cd ..
cd FastAPSP-master
    make clean
    make
cd ..
cd SOF-master
    make clean
    make
cd ..
for ((j=10000; j<=$maxk; j+=$incrementk)); do
    time_fas=0
    time_sof=0
    time_hog=0
    for ((i=1; i<=$const; i++)); do
        ./a.out "$j" "$n" "n"
        echo "testcase $i"
        #run hog
        cd HOG-main
        X=`(time ./a.out "../input.txt") 2>&1| grep user`
        SYS_TIME=${X:5}
        time_hog=$(echo "$time_hog + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run fast APSP
        cd FastAPSP-master
        X=`(time ./FastAPSP "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_fas=$(echo "$time_fas + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run SOF
        cd SOF-master
        X=`(time ./Apsp "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_sof=$(echo "$time_sof + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run readjoiner
        cd gt-1.6.2-Linux_x86_64-64bit-complete
        myreadset="myreadset"
        Y=`(time gt readjoiner prefilter -readset "$myreadset" -db "../input.fa") 2>&1| grep user`
        SYS_TIME=${Y:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        X=`(time gt -j 1 readjoiner overlap -readset "$myreadset" -l 2) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..
    done
    >output.txt
    echo "HOG N=$n and K=$j t= $(echo "scale=5; $time_hog / $const" | bc)">>output.txt
    echo "FAST N=$n and K=$j t= $(echo "scale=5; $time_fas / $const" | bc)">>output.txt
    echo "READ N=$n and K=$j t= $(echo "scale=5; $time_read / $const" | bc)">>output.txt
    echo "SOF N=$n and K=$j t= $(echo "scale=5; $time_sof / $const" | bc)">>output.txt
    file="N-$n-K-$j-eq-y_results.txt"
    cp output.txt output/$file
done
for ((j=1000000; j<=$max; j+=$increment)); do
    for ((i=1; i<=$const; i++)); do
        ./a.out "$k" "$j" "n"
        echo "testcase $i"
        #run hog
        cd HOG-main
        X=`(time ./a.out "../input.txt") 2>&1| grep user`
        SYS_TIME=${X:5}
        time_hog=$(echo "$time_hog + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run fast APSP
        cd FastAPSP-master
        X=`(time ./FastAPSP "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_fas=$(echo "$time_fas + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run SOF
        cd SOF-master
        X=`(time ./Apsp "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_sof=$(echo "$time_sof + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run readjoiner
        cd gt-1.6.2-Linux_x86_64-64bit-complete
        myreadset="myreadset"
        Y=`(time gt readjoiner prefilter -readset "$myreadset" -db "../input.fa") 2>&1| grep user`
        SYS_TIME=${Y:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        X=`(time gt -j 1 readjoiner overlap -readset "$myreadset" -l 2) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..
    done
    >output.txt
    echo "HOG N=$j and K=$k t= $(echo "scale=5; $time_hog / $const" | bc)">>output.txt
    echo "FAST N=$j and K=$k t= $(echo "scale=5; $time_fas / $const" | bc)">>output.txt
    echo "READ N=$j and K=$k t= $(echo "scale=5; $time_read / $const" | bc)">>output.txt
    echo "SOF N=$j and K=$k t= $(echo "scale=5; $time_sof / $const" | bc)">>output.txt
    file="N-$j-K-$k-eq-n_results.txt"
    cp output.txt output/$file
done
for ((j=1000; j<=$maxk; j+=$incrementk)); do
    for ((i=1; i<=$const; i++)); do
        ./a.out "$j" "$n" "y"
        echo "testcase $i"
        #run hog
        cd HOG-main
        X=`(time ./a.out "../input.txt") 2>&1| grep user`
        SYS_TIME=${X:5}
        time_hog=$(echo "$time_hog + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run fast APSP
        cd FastAPSP-master
        X=`(time ./FastAPSP "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_fas=$(echo "$time_fas + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run SOF
        cd SOF-master
        X=`(time ./Apsp "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_sof=$(echo "$time_sof + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run readjoiner
        cd gt-1.6.2-Linux_x86_64-64bit-complete
        myreadset="myreadset"
        Y=`(time gt readjoiner prefilter -readset "$myreadset" -db "../input.fa") 2>&1| grep user`
        SYS_TIME=${Y:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        X=`(time gt -j 1 readjoiner overlap -readset "$myreadset" -l 2) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..
    done
    >output.txt
    echo "HOG N=$n and K=$j t= $(echo "scale=5; $time_hog / $const" | bc)">>output.txt
    echo "FAST N=$n and K=$j t= $(echo "scale=5; $time_fas / $const" | bc)">>output.txt
    echo "READ N=$n and K=$j t= $(echo "scale=5; $time_read / $const" | bc)">>output.txt
    echo "SOF N=$n and K=$j t= $(echo "scale=5; $time_sof / $const" | bc)">>output.txt
    file="N-$n-K-$j-eq-y_results.txt"
    cp output.txt output/$file
done
for ((j=1000; j<=$maxk; j+=$incrementk)); do
    for ((i=1; i<=$const; i++)); do
        ./a.out "$j" "$n" "n"
        echo "testcase $i"
        #run hog
        cd HOG-main
        X=`(time ./a.out "../input.txt") 2>&1| grep user`
        SYS_TIME=${X:5}
        time_hog=$(echo "$time_hog + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run fast APSP
        cd FastAPSP-master
        X=`(time ./FastAPSP "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_fas=$(echo "$time_fas + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run SOF
        cd SOF-master
        X=`(time ./Apsp "../input.txt" -p 1) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_sof=$(echo "$time_sof + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..

        #run readjoiner
        cd gt-1.6.2-Linux_x86_64-64bit-complete
        myreadset="myreadset"
        Y=`(time gt readjoiner prefilter -readset "$myreadset" -db "../input.fa") 2>&1| grep user`
        SYS_TIME=${Y:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        X=`(time gt -j 1 readjoiner overlap -readset "$myreadset" -l 2) 2>&1| grep user`
        SYS_TIME=${X:5}
        time_read=$(echo "$time_read + $(convert_to_seconds "$SYS_TIME")" | bc)
        cd ..
    done
    >output.txt
    echo "HOG N=$n and K=$j t= $(echo "scale=5; $time_hog / $const" | bc)">>output.txt
    echo "FAST N=$n and K=$j t= $(echo "scale=5; $time_fas / $const" | bc)">>output.txt
    echo "READ N=$n and K=$j t= $(echo "scale=5; $time_read / $const" | bc)">>output.txt
    echo "SOF N=$n and K=$j t= $(echo "scale=5; $time_sof / $const" | bc)">>output.txt
    file="N-$n-K-$j-eq-n_results.txt"
    cp output.txt output/$file
done
