"""
    Game: Guess the number!
    Author: Xiangzhu Long
    Date: June, 12, 2015
    """

import simplegui
import random
import math

secret_number = 0
num_range = 100
guess_left = 0


def new_game():
    '''
        helper function to start and restart the game
        '''
    # initialize global variables used in your code here
    global secret_number
    global num_range
    global guess_left
    
    if(num_range == 100):
        guess_left = 7
    else:
        guess_left = 10

    secret_number = random.randrange(0, num_range)

    print
    print "Game Start! Rock it with a number 0 ~", num_range, "!"
    print "You have", guess_left, "opportunities to guess!"


# define event handlers for control panel
def range100():
    # button that changes the range to [0,100)
    # and starts a new game
    global num_range
    num_range = 100
    
    new_game()

def range1000():
    # button that changes the range to [0,1000)
    # and starts a new game
    global num_range
    num_range = 1000
    
    new_game()

def input_guess(guess):
    '''
        main game logic goes here
        '''
    global secret_number
    global guess_left
    
    print "Guess was ", guess, "."
    guess_int = int (guess)
    
    if(secret_number == guess_int):
        print "You damn it!"
        new_game()
        return
    if(secret_number < guess_int):
        print "It is higher, think about a lower one!"
    if(secret_number > guess_int):
        print "It is lower, think about a higher one!"
    
    guess_left = guess_left - 1
    if(guess_left == 0):
        print "Game over! ><..."
        print "Haha, the secret number is", secret_number, "."
        new_game()
    else:
        print "You have", guess_left, "opportunities to guess!"




# create frame
frame = simplegui.create_frame("Guess the number!", 300, 300)
frame.set_canvas_background('Blue')

# register event handlers for control elements and start frame
frame.add_button("Easy [0, 100)", range100, 100)
frame.add_button("Hard [0, 1000)", range1000, 100)
frame.add_input("Please guess a number: ", input_guess, 100)

# call new_game
new_game()
frame.start()
