extends Node3D


@onready var path = preload("res://Mobs/Stage_1.tscn")


func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)
