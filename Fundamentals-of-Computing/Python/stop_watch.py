"""
    Stopwatch Game
    Author: Xiangzhu Long
    Date: 19 June, 2015
    """

import simplegui

# define global variables
interval = 100  # 0.1 second
count = 0
sum_stops = 0
sum_succ_stops = 0
is_stop = True


def format(t):
    '''
        define helper function format that converts time
        in tenths of seconds into formatted string A:BC.D
        '''
    second_10th = t % 10
    seconds = int(t / 10) % 10
    minute_10th = int(t / 100) % 6
    minutes = int(t / 600) % 600
    
    time_show = str(minutes) + ":" + str(minute_10th) + str(seconds) + ":" + str(second_10th)
    return time_show

# define event handlers for buttons; "Start", "Stop", "Reset"
def start():
    global count
    global is_stop
    is_stop = False
    timer.start()

def stop():
    global sum_stops
    global sum_succ_stops
    global is_stop
    if is_stop == False:
        if count % 10 == 0 and count != 0 :
            sum_succ_stops += 1
            sum_stops += 1
        elif count != 0 :
            sum_stops += 1
    timer.stop()

def reset():
    global count
    global sum_succ_stops
    global sum_stops
    count = 0
    is_stop = True
    sum_stops = 0
    sum_succ_stops = 0
    timer.stop()

def tick():
    '''
        define event handler for timer with 0.1 sec interval
        '''
    global count
    count += 1

# define draw handler
def draw(canvas):
    text = format(count)
    canvas.draw_text( text, (80, 125), 42, "black")
    canvas.draw_text(str(sum_succ_stops) + '/' + str(sum_stops),
                     (190,30), 24, "blue")


# create frame
frame = simplegui.create_frame("Stopwatch Game", 250, 250)
frame.set_canvas_background('white')

# register event handlers
frame.add_button("Start", start, 100)
frame.add_button("Stop", stop, 100)
frame.add_button("Reset", reset, 100)
frame.set_draw_handler(draw)
timer = simplegui.create_timer(interval, tick)

# start frame
frame.start()
reset()