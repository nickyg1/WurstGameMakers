extends StaticBody3D

var Bullet = preload("res://Tower/Bullet.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr

var reload = 0
var range = 400

func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	#update_powers()

func _on_mob_detector_body_entered(body):
	if "UFO" in body.name:
		var tempArray = []
		currTargets = get_node("MobDetector").get_overlapping_bodies()
		for i in currTargets:
			if "UFO" in i.name:
				tempArray.append(1)
		var currTarget = null
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
					
		curr = currTarget
		pathName = currTarget.get_parent().name
		Shoot()
		
func Shoot():
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position
