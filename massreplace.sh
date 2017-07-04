#!/bin/sh
#https://www.ibm.com/support/knowledgecenter/en/linuxonibm/liabo/liaboconcept.htm
#
#Authors: Michele Modolo, Eszter Nemeth
#Date: 04/07/2017
#GIT-Project: massreplace (owned by my friend Eszter)
#
#This scripts lists all the files in a given directory and replace some strings with other strings in each file 
#
#In this example the script replaces "ICMNLSDB" with "ITALY" and "ICMADMIN" with "HUNGARY" within each file
#The logic of this script is very clear (and can be reused for different purposes) and so is its syntax 

for file in $(find . -type f)
    do
           sed 's/ICMNLSDB/ITALY/g; s/ICMADMIN/HUNGARY/g' $file > $file.tmp
           mv $file.tmp $file
done
