extends Node2D

@onready var player = $AudioStreamPlayer2D

func play_audio(id:String):
	player.stream = load(id)
	player.play()
