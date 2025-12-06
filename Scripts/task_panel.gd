extends Panel

@onready var task_text = get_node("HBoxContainer/task_name_label")


func _on_trashcan_button_pressed() -> void:
	queue_free()
