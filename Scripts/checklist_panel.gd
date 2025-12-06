extends Panel

@export var task_panel : PackedScene

@onready var cont = $ScrollContainer/VBoxContainer
@onready var line_edit = $ScrollContainer/VBoxContainer/LineEdit


func add_task(taskname: String):
	var task = task_panel.instantiate()
	cont.add_child(task)
	
	task.task_text.text = taskname
	line_edit.clear()

func _on_line_edit_text_submitted(new_text: String) -> void:
	add_task(new_text)
