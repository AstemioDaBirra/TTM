extends Control

#region --- NODE REFERENCES ---
@onready var timer_name_label: RichTextLabel = get_node("timer_name_label")
@onready var timerlabel: RichTextLabel = get_node("HBoxContainer/NinePatchRect/timer_label")
@onready var play_pause_button: TextureButton = get_node("HBoxContainer/playpause_button")
@onready var  timer: Timer = get_node("Timer")
@onready var audio_player: AudioStreamPlayer = get_node("AudioStreamPlayer")
#endregion

#region --- ASSET REFERENCES ---
@onready  var play_button_up = load("res://art/play_up.png")
@onready  var play_button_down = load("res://art/play_down.png")
@onready  var pause_button_up = load("res://art/pause_up.png")
@onready  var pause_button_down = load("res://art/pause_down.png")
#endregion

#region --- VARIABLES ---
@export var timerName:String
@export var time:float
#@export var paused : bool

@export var audio_clips:Array[String]

signal timer_complete

#endregion

#region --- METHODS ---
func _ready() -> void:
	timer_name_label.text =  timerName #set the timer name on the UI panel
	timer.wait_time = time #set the timer's time based on the variable
	#timerlabel.text = str(int(timer.wait_time)) #set the time left label text
	timerlabel.text = _get_converted_time(int(timer.time_left))
	_on_restart_button_pressed() #run this method to reset the play button textures, reset the timer, and set paused as true.
	
	

func _process(delta: float) -> void:
	#timerlabel.text = str(int(timer.time_left))
	timerlabel.text = _get_converted_time(int(timer.time_left))

func _play_pause_timer():
	if timer.paused == true: #If the timer is paused...
		timer.paused = false #...set the timer to not paused...
		timer.start(timer.time_left) #...start the timer...
		#change the texture assets of the button to the play button ones.
		play_pause_button.texture_normal = pause_button_up
		play_pause_button.texture_pressed = pause_button_down
		#print(timer.paused)
		
	elif timer.paused == false: #If the timer is not paused...
		timer.paused = true #...set the timer to paused...
		print(timer.paused) #...stop the timer...
		#change the texture assets of the button to the pause button ones.
		play_pause_button.texture_normal = play_button_up
		play_pause_button.texture_pressed = play_button_down

func _get_converted_time(time:int)-> String:
	#this function returns the time ina minutes:seconds format
	var minutes: int = floor(time/60) #divide the time by 60 and only select the whole numbers
	var seconds: int = time - minutes * 60 #subtract minutes*60 from the time and get the seconds.
	var time_string: String = '%02d:%02d' % [minutes, seconds] #create a string for the minutes:seconds
	return time_string #return the string

func  _play_random_clip():
	var randclip = audio_clips.pick_random() #declare variable as a random string from the array
	audio_player.stream = load(randclip)  #load the asset in the stream
	audio_player.play() #play the sound

#region --- SIGNAL METHODS ---

func _on_playpause_button_pressed() -> void:
	_play_pause_timer()

func _on_restart_button_pressed() -> void:
	timer.start(time)
	timer.paused = true
	play_pause_button.texture_normal = play_button_up
	play_pause_button.texture_pressed = play_button_down
	audio_player.stop()

func _on_timer_timeout() -> void:
	print(timerName + " has run out!")
	_play_random_clip()
	timer_complete.emit()

#endregion

#endregion
