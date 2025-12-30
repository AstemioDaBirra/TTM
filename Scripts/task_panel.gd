extends Panel

@export var is_complete:bool

@onready var task_text = get_node("HBoxContainer/task_name_label")
@onready var check_button  = get_node("HBoxContainer/checkmark_button")

func _on_trashcan_button_pressed() -> void:
	queue_free()


func _on_checkmark_button_pressed() -> void:
	is_complete = check_button.button_pressed
