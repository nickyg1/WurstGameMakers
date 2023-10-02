extends StaticBody3D

var Bullet = preload("res://Tower/Bullet.tscn")
var bulletDamage = 4
var pathName
var currTargets = []
var curr

var reload = 0
var reloadSpeed = 5
var range = 400

func _process(delta):
	if currTargets.size() > 0:
		TargetCheck()
	
	if reload <= 0:
		Shoot()
	else:
		reload -= 5 * delta
	
	if is_instance_valid(curr):
		#I think it has to do something with OpenGL, but this makes the tower look 180deg the wrong way
		#I flipped the mesh *NOT THE TOWER* 180deg on the y-rot transform and it works
		self.look_at(curr.global_transform.origin, Vector3.UP)
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	
	#update_powers()

func _on_mob_detector_body_entered(body):
	if "UFO" in body.name:
		currTargets.append(body)
		
func _on_mob_detector_body_exited(body):
	currTargets.erase(body)

func TargetCheck():
	var currTarget
	
	for i in currTargets:
		if is_instance_valid(i):
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		else:
			currTargets.erase(i)
	
	curr = currTarget
	pathName = currTarget.get_parent().name
	
func Shoot():
	reload = 5
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position
