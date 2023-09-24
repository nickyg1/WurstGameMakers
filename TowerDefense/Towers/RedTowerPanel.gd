extends Panel

@onready var tower = preload("res://Towers/red_bullet_tower.tscn")
var currTile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempTower)
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		tempTower.scale = Vector2(0.1,0.1)
	
	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
		
		var mapPath = get_tree().get_root().get_node("Main/TileMap")
		var tile = mapPath.local_to_map(get_global_mouse_position())
		currTile = mapPath.get_cell_atlas_coords(0,tile,false)
		if currTile == Vector2i(4,5):
			get_child(1).get_node("Area").modulate = Color(0,255,0, 0.3)
		else:
			get_child(1).get_node("Area").modulate = Color(255,0,0, 0.3)
			
	elif event is InputEventMouseButton and event.button_mask == 0:
		
		if event.global_position.x >= 1500: #how can we get the position of the RedTowerPanel so this isn't hard coded
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:	
			if get_child_count() > 1:
				get_child(1).queue_free()
			if currTile == Vector2i(4,5):
				var path = get_tree().get_root().get_node("Main/TowersContainer")

				path.add_child(tempTower)
				#tempTower.global_position = event.global_position
				tempTower.global_position = get_global_mouse_position()
				tempTower.get_node("Area").hide()
				tempTower.scale = Vector2(0.32, 0.32)
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()	
