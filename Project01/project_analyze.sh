#!/bin/bash

cd ..

#0. color
RED='\033[00;31m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
RESTORE='\033[0m'
BLINK='\e[5m'

#1. make the script interactive,scoll down to see more
echo "This is Cynthia's project01"

#2. find lines with #TODO and add to a new file todo.log
TODO(){
        grep -r --exclude={'todo.log','README.md','project_analyze.sh'} "#TODO" > Project01/logs/todo.log
	echo -e "${BLUE}Lines with #TODO has been successfully added to todo.log.${RESTORE}"
	read -p "Would you like to see the log?(Y/N)" choice
	if [ "$choice" = "Y" ] ; then 
		cat Project01/logs/todo.log
	fi 
	read -p "Do you want to execute next function(Find_error)?(Y/N)" choice2
	if  [ "$choice2" = "Y" ] ; then  
                Find_error 
        fi 
}

#3 find error files and put them into compile_fail.log
Find_error(){
	hs_file=$(find . -iname "*.hs" -type f)
	echo -e "${PURPLE}This is what we get when running the haskell file${RESTORE}"
	ghc $hs_file	
	if [ $? -eq 0 ] ; then
		echo -e "${BLUE}This haskell file is executable${RESTORE}"
	else
		echo -e "${RED}It is not executable,added to compile_fail.log${RESTORE}"
	for f in $hs_file ; do
		echo "$hs_file" > Project01/logs/compile_fail.log
	done
	fi
	py_file=$(find . -iname "*.py" -type f)
	echo -e "${PURPLE}This is what we get when running the python file${RESTORE}"
        python $py_file     
        if [ $? -eq 0 ] ; then
       		echo -e "${BLUE}This python file is executable${RESTORE}"
        else
       		echo -e "${RED}It is not executable,added to compile_fail.log${RESTORE}"
        for f in $py_file ; do
                echo "$py_file" > Project01/logs/compile_fail.log
        done
        fi
	read -p "Do you want to execute next function(Find_merge)?(Y/N)" choice
	if  [ "$choice" = "Y" ] ; then  
                Find_merge
        fi 

}


#4. find commit hashes with merge and put them in merge.log
Find_merge(){
	git log --all --oneline | grep "merge" > Project01/logs/tempfile.txt
	cut -d " " -f1  Project01/logs/tempfile.txt  > Project01/logs/merge.log
	echo -e "${BLUE}Commit hashes of commit message with merge has been added to merge.log${RESTORE}"
	read -p "Would you like to see the log?(Y/N)" choice 
        if [ "$choice" = "Y" ] ; then  
        	cat Project01/logs/merge.log 
        fi 
	read -p "Do you want to execute next function(File_count)?(Y/N)" choice2
        if  [ "$choice2" = "Y" ] ; then  
                File_count
        fi 
}

#5. count how many of each files exist
File_count(){
	html=$(find . -iname "*.html" |wc -l)
	echo "HTML:$html"
	java=$(find . -iname "*.js" |wc -l)
	echo "Javascript:$java"
	CSS=$(find . -iname "*.css" |wc -l)
	echo "CSS:$CSS"
	python=$(find . -iname "*.py" |wc -l)
	echo "Python:$python"
	haskell=$(find . -iname "*.hs" |wc -l)
	echo "Haskell:$haskell"
	read -p "Do you want to execute next function(Del_tem)?(Y/N)" choice
        if  [ "$choice" = "Y" ] ; then  
                Del_tem
        fi 
}

#6. delete temporary files
Del_tem(){
	untracked=$(git ls-files *.tmp --exclude-standard --others)
	for item in $untracked ; do
		rm $item
	done
	echo -e "${BLUE}Temporary files have been deleted${RESTORE}"
	read -p "Do you want to execute next function(Mac_runtime)?(Y/N)" choice2
        if  [ "$choice2" = "Y" ] ; then  
                Mac_runtime
        fi 
}

#7. custom feature: get how long your mac has been running
Mac_runtime(){
	uptime
	read -p "Do you want to execute next function(Get_time)?(Y/N)" choice
        if  [ "$choice" = "Y" ] ; then  
                Get_time
        fi 
}

#8. custom feature: get the time it need to test a function
Get_time(){
	read -p "Enter the function you want to test(TODO/Find_error/Find_merge/File_count/Del_tem/Mac_runtime): " var2
	time "$var2" 
	read -p "Do you want to test another function?(Y/N)" choice
	if [ "$choice" = "Y" ] ; then  
                Get_time 
        fi 
	echo -e "${BLINK}This is the end of project01${RESTORE}"
}


#make the script interactive
read -p  "choose the feature to be executed a)TODO b)Find_error c)Find_merge d)File_count e)Del_tem f)Mac_runtime g)Get_time " var1

if [ "$var1" = "TODO" ] ; then 
	TODO
elif [ "$var1" = "Find_error" ] ; then
	Find_error
elif [ "$var1" = "Find_merge" ] ; then
	Find_merge
elif [ "$var1" = "File_count" ] ; then
	File_count
elif [ "$var1" = "Del_tem" ] ; then
	Del_tem
elif [ "$var1" = "Mac_runtime" ] ; then
	Mac_runtime
elif [ "$var1" = "Get_time" ] ; then
        Get_time
else
	echo -e "${RED}Sorry, your command cannot be found${RESTORE}"
fi
