# The General Purpose Project Helper
**By: Tahseen Ahmed**
February, 15th, 2019
## Etymology
**G**eneral **P**urpose **P**roject H**e**lper. Pronounced "gep-e", g as in "garage". The 'the' is optional.
## Purpose
GPPE's purpose is to assist in project development by providing simple, but useful features to the user and to provide a simple user interface to execute said features.

## Design
GPPE is a text-based script which asks for the user to select which feature to execute from a list of choices.
The script is recursive, once it executes a feature, it will go back and prompt the user again for a feature until the exit feature is used. 
I would have made a GUI, but I think that's out of my skillset as of now.

## Features
### The Interactive UI 
Upon starting up the script, you'll be greeted with this:
```
=====================================================
Select the action that best suits your needs:
Type in code word to execute command
Create TODO Log       - TODO
Last Modded File      - LMF
File Type Count       - FTC
Super Secret Function - IAMTHESENATE
End Script            - BYEBYE
=====================================================
```

It's a very simple and easy-to-follow UI, type the codeword for your desired action, and GPPE will do it for you. Be mindful of typos or null inputs (entering nothing): GPPE will ask you to input codeword again. GPPE exits when you use the codeword BYEBYE (or if you just close the window, however you want to do it is fine by me).

### TODO
TODO searches the entire repository for lines in files that contain "#TODO". It then compiles a list of them with their respective filepath (relative to current directory). The path for the log file is ./Project01/logs/todo.log

## LMF (Last Modified File)
LMF allows the user to find all files (hidden too) modified within a certain time frame. It can search for x minutes, hours or days. This feature only takes integers as the time interval, as it does integer airthmetic only.
The user inputs either M, H or D to first specify the time unit and then the amount of that time to search for like so:
```
=====================================================
Select a codeword: LMF
You chose the codeword: LMF

Tell me how far back you want to search for modified files, use integers please.
Use M for minutes, H for hours and D for days.
M, H or D? M
What interval? 20

=====================================================
Searching for files modified within the last 20 minute(s).
./.git
./.git/COMMIT_EDITMSG
./.git/logs/HEAD
./.git/logs/refs/remotes/origin/project01
./.git/logs/refs/heads/project01
./.git/index
./.git/refs/remotes/origin
./.git/refs/remotes/origin/project01
./.git/refs/heads
./.git/refs/heads/project01
./.git/FETCH_HEAD
./.git/objects
./.git/objects/a4
./.git/objects/a4/815a1da3feb5f4b29f3899ba11b970e50bb9b1
./.git/objects/3a
./.git/objects/3a/3518f3c4fe08ebc94b18c58e5380710ce6d01d
./.git/objects/43
./.git/objects/43/31dcc1b3c6c92b7399750a9eb2c6a667630a0b
./.git/objects/a9
./.git/objects/a9/0e0f87a5736a50c05580a95af63eb4be7fbafc
./Project01
./Project01/README.md

All done!
=====================================================
```

### FTC (File Type Count)
File Type Count returns a list of the extensions in the repository like so:
```
=====================================================
Select a codeword: FTC
You chose the codeword: FTC
 Counting filetypes in repository...

=====================================================
                       Results
HTML: 1
JavaScript: 0
CSS: 0
Python: 0
Haskell: 1
Bash Script: 2

Filetype Scan Complete!
=====================================================
```

For reference, the exact extensions FTC hunts for are:
* .html
* .js
* .css
* .py
* .hs 
* .sh

## IAMTHESENATE
This is nothing functional. It prints the Tragedy of Darth Plageuis quote from Star Wars Episode III: Revenge of the Sith.

## Summary
GPPE's a simple project assistant that helps with your work. It has a easy-to-use UI with a few features that hopefully should make your developer life a little easier.
