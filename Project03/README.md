# Maze Racer
### Tahseen Ahmed

## Introduction
Maze Racer is a single-player mouse-based game in which the player must complete a series of mouse mazes which increase in difficulty. This is the culminating project for my CS1XA3 class.

## Setup / How To Use
### Step 1: Python3 Virtual Environment
If you don't have one already, you should create a Python3 virtual environment which satisfies the requirements in the `requirements.txt` file in the project folder. It is most likely that the generated environment should have all the necessary versions to operate, but if you run into trouble, ```requirements.txt``` has the version numbers and packages you'll need to install in order for the game to work.

To create a python virtual environment, use these commands in a directory of your choice:

``` 
# python_venv name can be another name if you'd like.
$ python -m venv python_venv
# Enter the virtual environment using cd
$ cd python_env
# Activate it using the following command
$ source bin/activate
```
Once activated, you'll be able to use this project.

### Step 2: Activate Django Server
1. Go to ```Project03/django_project/ ```
2. Execute the following command: 
```python3 manage.py runserver localhost:[portnum]``` where [portnum] is a port number of your choosing. Ensure you're not using a port designated for someone or something else.

### Step 3: Access Maze Racer
Maze Racer is configured to be accesed via [this link](https://mac1xa3.ca/e/ahmedt26/Project03/) when the Django server is active (https://mac1xa3.ca/e/ahmedt26/Project03/).
If cannot for some reason access the app through this method, you can use https://mac1xa3.ca/u/ahmedt26/project3.html which is the game served off of the 1XA3 server rather than my own.

## Features
There are various features implemented in Maze Racer:
- __Elm!__
  - Maze Racer is programmed in Elm! A functional programming language which compiles into JavaScript.
  - __List of methods/features used in in code__
    - If/else statements
    - Case expressions/Pattern matching
    - State management (which menu screen to show, etc.)
    - Type aliases
    - Mouse events
    - Self-made functions
    - Community-made modules
    - Lots of custom message types
    - _McMaster's very own GraphicSVG_

- __Animated Menu Screen__
  - Using GraphicSVG, Maze Racer's simple, yet intuitive menu screen is easy to navigate and use. Colourful buttons and text that sway left and right and a zooming title screen are all what consists of Maze Racer's attractive navigation system.
- __Three Stages of Fun!__
  - Maze Racer gives you 3 stages of mouse-moving fun, each increasing in difficulty. 
  - Each level uses GraphicSVG's shapes and texts to display the level. The 2nd and 3rd levels use animations to make the levels move to give a greater challenge. 
  - In addition, the game uses notifications to check if the user is properly completing the stage by checking if they clicked the start, the end, or have not touched the bounds of the maze.
- __High Score Table__
  - Maze Racer has its own local high score table which displays the user's time and positiong in each respective stage. The more you play, the more you can see yourself on the leaderboard. Try to take up all the spots!
- __Django Backend__
  - Maze Racer is served through Django (which is served by the mac1xa3 server ultimately). The entire project can be taken and deployed to your own server if you wish (don't steal my project ): )with the except that you need another virtual environment to run it.
 
## Closing Remarks
I hope you enjoy my game. As much as CS is all about encryption, algorithims, currying etc., it's nice to make a few games here and there.
