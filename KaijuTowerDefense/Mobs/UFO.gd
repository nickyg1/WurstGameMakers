extends CharacterBody3D


@export var speed = 2
var Health = 10

@onready var Path = get_parent()

func _physics_process(delta):
	Path.set_progress(Path.get_progress() + speed*delta)
	
	if Path.get_progress_ratio() >= 0.99:
		death()
		
	if Health <= 0:
		death()

func death():
	Path.get_parent().queue_free()
