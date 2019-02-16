# The General Purpose Project Helper
**By: Tahseen Ahmed**
February, 15th, 2019

## Welcome to GPPE
GPPE's (pronounced gep-e,) purpose is to assist in project development and provide an interface to execute the script's features.

## Design
GPPE is a text-based script which asks for the user to select which feature to execute from a list of choices.
GPPE takes no inputs, instead you execute the script and it's menu will come up (before a cool loading screen, of course).
The script is recursive, once it executes a feature, it will go back and prompt the user again for a feature until the exit feature is used. 
I would have made a GUI, but I believe that's out of my skillset as of now.

## Current Features
### The UI
Upon starting up the script, you'll be greeted with this:
```
=====================================================
   Welcome to the General Purpose Project Helper!
              By: Tahseen Ahmed, ahmedt26
=====================================================

=====================================================
Select the action that best suits your needs:
Type in code word to execute command
Create TODO Log       - TODO
File Type Count       - FTC (Not Implemented Yet)
Super Secret Function - IAMTHESENATE
End Script            - BYEBYE
=====================================================
```
It's a very simple and easy-to-follow UI, type the codeword for your desired action, and GPPE will do it for you. Be mindful of typos or null inputs: GPPE will ask you to input codeword again. GPPE exits when you use the codeword BYEBYE (or if you just close the window, however you want to do it is fine by me).

### TODO
TODO searches the entire repository for lines in files that contain "#TODO". It then compiles a list of them with their respective filepath (relative to current directory) in a todo.log file.

### FTC (WIP)
The Filetype Count--once it's implemented-- will return the number of HTML, JavaScript, CSS, Python, Haskell and Bash Script files are in the repository. It should return as a neat list of numbers beside their respective extension. 
For reference, the exact extensions FTC hunts for are:
* .html
* .css
* .py
* .hs 
* .sh
* 
### IAMTHESENATE
The script reveals an ancient and tragic story of a Sith Lord...

## Summary
GPPE is a text-based project assistant designed to do simple things. It's light, easy-to-use and hopefully will assist you in your endeavours.

