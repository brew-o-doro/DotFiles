#!/bin/bash
# baraction.sh for spectrwm status bar

## Date
dte() {
	dte="$(date +"%A, %B %d %l:%M%p")"
	echo -e "$dte"
}

## DISK
hdd(){
	hdd="$(df -h | awk 'NR==4{print $3, $5}')"
	echo -e "HDD: $hdd"
}

## RAM
mem(){
	mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 8024.0, $2 /8024.0'`
echo -e "MEM: $mem"
}

## CPU
cpu(){
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+B+C+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle)) / (total-prevtotal) ))
}

## VOLUME 
vol(){
	vol=`amixer get Master | awk -F'[][]' 'END{print $4":"$2 }'`
	echo -e "VOL: $vol"
}

SLEEP_SEC=5
#loops forever outputting line every SLEEP_SEC
while :; do 
	echo "$(cpu) | $(mem) | $(hdd) | $(dte)"
	sleep $SLEEP_SEC
done 

