#!/bin/bash
#submitted by Mohammed_Ismail, Ethical_hacking
#variable
dom=$1
#greeting
greeting()
{
echo -e "\e[1;36m welcome $USER \e[0m"
echo -e "\e[1;36m Thank you for using our script \e[0m"
}
#Subdoamins_collections
subs_enum()
{
echo -e "\e[1;32m Collecting Subdomains of $dom \e[0m"
assetfinder -subs-only $dom > subs.txt
#checking_alived
echo -e "\e[1;32m checking for alived subdomains \e[0m" 
cat subs.txt | httprobe > alive_subs.txt
#sorting
echo -e "\e[1;32m sorting the domains \e[0m"
subs=$alive_subs.txt
while read subs ; do
	echo ${subs#*//} >> url.txt
done < alive_subs.txt
sort -u url.txt > subs_of_$dom.txt
cat subs_of_$dom.txt
#informations
count=$(cat subs_of_$dom.txt | wc -l)
echo -e "\e[1;33m total $count subdomains captured\e[0m"
location=$(pwd)
echo -e "\e[5;33m file saved in $location \e[0m"
#temprory_file_remove
rm subs.txt
rm alive_subs.txt
rm url.txt
}
#main
if [[ -z $dom ]]; then
	echo -e "\e[1;5;31m syntax error! \e[0m"
	echo -e "\e[1;32m give a domain name \e[0m"
	echo -e "\e[1;4;32m example:$0 example.com \e[0m"
else
	greeting
	subs_enum
fi
