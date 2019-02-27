#!/bin/bash

cd ..

# Fancy script startup. It's nothing functional. Trying to make it seem more like a UI.
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

# I made this UI to be fairly intuitive. The only reason for
# someone to read the README is for detailed instructions
# on what each of the features do, and not for UI-related help.
# Regardless, I've iven instructions on how to use the UI
# for time travellers.
echo '====================================================='
echo '   If this is your first time touching a computer... '
sleep 0.5
echo '        Nice time travel, read the README.           '
echo '====================================================='

sleep 0.5
echo ' ' 
selectScreen() { # Prints a menu which displays available actions.
echo '====================================================='
echo 'Select the action that best suits your needs:        '
sleep 0.20
echo 'Type in code word to execute command                 '
sleep 0.20
echo 'Create TODO Log       - TODO                         '
sleep 0.20
echo 'Last Modded File      - LMF                          '
sleep 0.20
echo 'File Type Count       - FTC                          '
sleep 0.20
echo 'Super Secret Function - IAMTHESENATE                 '
sleep 0.20
echo 'End Script            - BYEBYE                       ' 
echo '====================================================='
}

selectAction() { # Executes feature if correct code word is given, or asks to try again if given nothing or something else.
	read -p 'Select a codeword: ' code
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
		fileTypeCount
		echo ' I did not do this yet! :( Sorry. '
	elif [ $code = 'LMF' ]; then
		echo "You chose the codeword: $code"
		lastModdedFile
	elif [ $code -eq 0 ]; then
		echo "You gave me no input! Try again."
		selectAction
	else
		echo "You gave me gibberish or had a typo. Check caps and spelling."
		selectAction
	fi
}

toDo() { # Creates a log of lines with #TODO in them along with their respective filepaths.
	echo ' '
	echo '====================================================='
	echo 'Creating a To Do Log File and finding TODO items...'
	rm -f ./Project01/logs/todo.log
	touch ./Project01/logs/todo.log
	grep -r '#TODO' --exclude="project_analyze.sh" --exclude="README.md" --exclude="todo.log" . >> ./Project01/logs/todo.log
	sleep 0.25
	echo 'Log file compliled!'
	echo ' ' 
	echo '=====================================================' # Reads file to user for convienence.
	echo '                Here is what I found:                '
	cat ./Project01/logs/todo.log
	echo '====================================================='
	echo ' '
	selectScreen
	selectAction
}

fileTypeCount() { # Counts the number of filetype extensions in the repository. WIP
	echo ' Counting filetypes in repository...'
	
	html=$(find . -name "*.html" | wc -l)
	javascript=$(find . -name "*.js" | wc -l)
	css=$(find . -name "*.css" | wc -l)
	py=$(find . -name "*.py" | wc -l)
	haskell=$(find . -name "*.hs" | wc -l)
	bsh=$(find . -name "*.sh" | wc -l)
	sleep 0.5 # The output: a fancy display of all the totals.
	echo ' '
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
	echo "Haskell: $haskell"
	sleep 0.20
	echo "Bash Script: $bsh"
	sleep 0.20
	echo ' ' 
	echo 'Filetype Scan Complete!'
	echo '====================================================='
	echo ' '
	selectScreen # Call selectScreen again to pick another ation.
	selectAction
}

lastModdedFile() { # Finds all modified files within the last x minutes/hours/days in the current directory (project repo).
	echo ' '
	echo 'Tell me how far back you want to search for modified files, use integers please.'
	sleep 1.0
	echo 'Use M for minutes, H for hours and D for days.'
	sleep 1.0
	read -p 'M, H or D? ' unit # Read user's time frame.
	read -p 'What interval? ' interval
	if [ $unit = 'M' ] ; then
		echo ' '
		echo '====================================================='
		echo "Searching for files modified within the last $interval minute(s)."
		find . -mmin -$interval #-mmin takes the input as minutes, and the - before the number means less than or equal to.
		echo ' '
		echo 'All done!'
		echo '====================================================='
		echo ' ' 
		selectScreen
		selectAction
	fi
	if [ $unit = 'H' ] ; then
		echo ' '
		echo '====================================================='
		echo "Searching for files modified within the last $interval hour(s)."
		find . -mmin -$(($interval * 60))
		echo ' '
		echo 'All done!'
		echo '====================================================='
		echo ' '
		selectScreen
		selectAction
	fi
	if [ $unit = 'D' ] ; then
		echo ' '
		echo '====================================================='
		echo "Searching for files modified within the last $interval day(s)."
		find . -mtime -$interval # -mtime takes the input as number of days.
		echo ' ' 
		echo 'All done!'
		echo '====================================================='
		echo ' '
		selectScreen
		selectAction
		
	fi
}
order66() { # I am the senate. Prints the Tradedy of Darth Plaeuis Copypasta.
	echo ' '
	echo '====================================================='
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
	echo '====================================================='
	echo ' ' 
	sleep 1
	selectScreen
	selectAction
}

byebye() { # Exits script.
	echo "Goodbye!"
	sleep 0.25
	exit 0;
}


# Actual initialization of program functions. Will recursively go through actions until BYEBYE code used.

selectScreen

selectAction

