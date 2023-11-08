extends Camera3D

var mouse_sens = 0.3
var move_speed = 0.3;


# Called when the node enters the scene tree for the first time.
func _ready():
	print("enter scene")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_moveCameraPosition()
	if Input.is_key_pressed(KEY_H):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_key_pressed(KEY_J):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	pass
	

func _input(event):         
	if event is InputEventMouseMotion:
		print("X Mouse: " + str(event.relative.x))
		print("Y Mouse: " + str(event.relative.y))
		rotate_y(deg_to_rad(clamp(-event.relative.x, -1, 1)*mouse_sens))
		rotate_x(deg_to_rad(clamp(-event.relative.y, -1, 1)*mouse_sens))

func _moveCameraPosition():
	if Input.is_key_pressed(KEY_W):
		position.z -= move_speed
	if Input.is_key_pressed(KEY_S):
		position.z += move_speed
	if Input.is_key_pressed(KEY_A):
		position.x -= move_speed;
	if Input.is_key_pressed(KEY_D):
		position.x += move_speed;
	if Input.is_key_pressed(KEY_Q):
		position.y -= move_speed;
	if Input.is_key_pressed(KEY_E):
		position.y += move_speed;
