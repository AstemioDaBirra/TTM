extends Node2D

@onready var checklist_panel = $UI/VBoxContainer/checklist_panel
@onready var checklist_line_edit = $UI/VBoxContainer/checklist_panel/VBoxContainer2/LineEdit
@onready var timer_panel = $UI/VBoxContainer/timerlist_panel

@export var check_list: Array[TaskData]
@export var timer_list: Array[TimerData]

func _ready() -> void:
	
	# connect to the lineEdit event
	checklist_line_edit.text_submitted.connect(_add_taskdata_resource)
	
	# create a checklist item for every checklist resource in the list.
	for check in check_list:
		checklist_panel.add_task_panel(check.task_name, check.is_complete)

func _add_taskdata_resource(new_text: String):
	#create the resource
	var new_resource = TaskData.new()
	
	#set the values for the new resource
	new_resource.task_name = new_text
	new_resource.is_complete = false
	
	#add the resource to the list
	check_list.append(new_resource)
	
	print("Task %s added. Amount of current tasks: %s" % [new_text, check_list.size()]) #check if the element was added.
	
	#print(check_list.size()) #check if the element was added
	#print("New task added: " + new_text) # print to check if the events connect.

func _delete_taskdata_resource(data_name: String):
	var task_to_delete = check_list.find(data_name) #find the data in the array.
	task_to_delete.erase() #delete the data from the array.
	print("Task %s removed. Amount of remaining tasks: %s" % [data_name, check_list.size()]) #check if the element was removed.
