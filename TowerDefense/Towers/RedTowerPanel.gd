extends Panel

@onready var tower = preload("res://Towers/red_bullet_tower.tscn")
var currTile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempTower)
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		tempTower.scale = Vector2(0.32,0.32)
	
	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
	
	elif event is InputEventMouseButton and event.button_mask == 0:
		
		if event.global_position.x >= 1500: #how can we get the position of the RedTowerPanel
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:	
			if get_child_count() > 1:
				get_child(1).queue_free()
					
			var path = get_tree().get_root().get_node("Main/TowersContainer")

			path.add_child(tempTower)
			tempTower.global_position = event.global_position
			tempTower.get_node("Area").hide()
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()	
