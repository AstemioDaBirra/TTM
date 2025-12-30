extends Panel

@export var task_panel : PackedScene

@onready var cont = $VBoxContainer2/ScrollContainer/VBoxContainer
@onready var line_edit = $VBoxContainer2/LineEdit


func add_task_panel(taskname: String, complete:bool):
	var task = task_panel.instantiate() #instantiate a new task panel.
	
	cont.add_child(task) #add it as a child of the VBoxcontainer.
	
	task.task_text.text = taskname #set the text as the one input.
	task.is_complete = complete #set the complete status as
	
	if complete == true:
		print("true")
		task.get_child(1).get_child(1).set_pressed_no_signal(true)
	else:
		print("false")
	
	line_edit.clear()

func _on_line_edit_text_submitted(new_text: String) -> void:
	add_task_panel(new_text, false)
