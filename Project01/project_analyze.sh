#!/bin/bash

cd ..

# Fancy script startup. It's nothing functional.
echo ' '
echo '====================================================='
echo '               ...Initializing GPPE...               '
echo '====================================================='
echo ' '

sleep 0.5
echo '                   ...............                   '
sleep 0.5
echo '              .......Epic Buildup........            '
sleep 0.5
echo '                   ...............                   '
sleep 0.5

echo ' '
echo '====================================================='
echo '   Welcome to the General Purpose Project Helper!    '
sleep 0.5
echo '              By: Tahseen Ahmed, ahmedt26            '
echo '====================================================='

sleep 0.5
echo ' ' 

selectScreen() { # Calls the available actions to output.
echo '====================================================='
echo 'Select the action that best suits your needs:        '
sleep 0.20
echo 'Type in code word to execute command                 '
sleep 0.20
echo 'Create TODO Log       - TODO                         '
sleep 0.20
echo 'File Type Count       - FTC (Not Implemented Yet)    '
sleep 0.20
echo 'Super Secret Function - IAMTHESENATE                 '
sleep 0.20
echo 'End Script            - BYEBYE                       ' 
echo '====================================================='
}

selectAction() { # Used to select which action to execute.
	read code
	if [ $code = 'BYEBYE' ]; then
		echo "You chose the codeword: $code"
		byebye
	elif [ $code = 'IAMTHESENATE' ]; then
		echo "You chose the codeword: $code"
		order66
	elif [ $code = 'TODO' ]; then
		echo "You chose the codeword: $code"
		toDo
	elif [ $code = 'FTC' ]; then
		echo "You chose the codeword: $code"
		# fileTypeCount
		echo ' I did not do this yet! :( Sorry. '
		selectAction
	elif [ $code -eq 0 ]; then
		echo "You gave me no input! Try again."
		selectAction
	else
		echo "You gave me gibberish or had a typo. Check caps and spelling."
		selectAction
	fi
}

toDo() { # Finds all lines with #TODO in them and prints them in todo.log
	echo ' '
	echo '====================================================='
	echo 'Creating a To Do Log File and finding TODO items...'
	rm -f ./Project01/todo.log
	touch ./Project01/todo.log
	grep -r '#TODO' --exclude="project_analyze.sh" --exclude="README.md" --exclude="todo.log" . >> ./Project01/todo.log
	sleep 0.25
	echo 'Log file compliled!'
	echo '====================================================='
	echo ' '
	selectScreen
	selectAction
}

fileTypeCount() { # Finds require filetpes, not in working order yet
	echo ' Counting filetypes in repository...'
	filenames=$(find ./ -iname "*" -print0 | xargs -0 grep -ril "*" ) 
	html=0
	javascript=0
	css=0
	py=0
	hs=0
	bsh=0
	for filename in $filenames ; do # Refactored code from data_collect.sh
		echo ' '
		echo '====================================================='
		echo "Checking $filename"
		if [ ${filename: -4} == ".css" ] ; then
			echo "CSS count up"
			css=$((css + 1))
		fi
		if [ ${filename: -3} == ".js" ] ; then
			echo "JavaScript count up"
			javascript=$((javascript + 1))
		fi
		if [ ${filename: -3} == ".py" ] ; then
			echo "Python count up"
			py=$((py + 1))
		fi
		if [ ${filename: -3} == ".hs" ] ; then
			echo "Haskell count up"
			hs=$((hs + 1))
		fi
		if [ ${filename: -3} == ".sh" ] ; then
			echo "Bash count up"
			bsh=$((bsh + 1))
		fi
		if [ ${filename: -5} == ".html" ] ; then
			echo "HTML count up"
			html=$((html + 1))
		fi
	done
	
	sleep 0.5
	echo '====================================================='
	echo '                       Results                       '
	sleep 0.20
	echo "HTML: $html"
	sleep 0.20
	echo "JavaScript: $javascript"
	sleep 0.20
	echo "CSS: $css"
	sleep 0.20
	echo "Python: $py"
	sleep 0.20
	echo "Bash Script: $bsh"
	sleep 0.20
	echo 'Filetype Scan Complete!'
	echo '====================================================='
	echo ' '
	selectScreen
	selectAction
}

order66() {
	echo ' '
	echo 'Did you ever hear the tragedy of Darth Plagueis The Wise?'
	sleep 1
	echo 'I thought not.'
	sleep 1
	echo 'Its not a story the Jedi would tell you. Its a Sith legend. '
	sleep 1
	echo 'Darth Plagueis was a Dark Lord of the Sith,' 
	sleep 1
	echo 'so powerful and so wise he could use the Force to influence the midichlorians to create life '
	sleep 1
	echo 'He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. '
	sleep 1
	echo 'The dark side of the Force is a pathway to many abilities some consider to be unnatural. '
	sleep 1
	echo 'He became so powerful the only thing he was afraid of was losing his power, which eventually, of course, he did. '
	sleep 1
	echo 'Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. '
	sleep 1
	echo '...'
	sleep 1
	echo 'Ironic.' 
	sleep 1
	echo 'He could save others from death, but not himself.'
	echo ' '
	sleep 1
	selectScreen
	selectAction
}

byebye() {
	echo "Goodbye!"
	sleep 0.25
	exit 0;
}


# Actual initialization of program functions. Will recursively go through actions until BYEBYE code used.
selectScreen

selectAction

