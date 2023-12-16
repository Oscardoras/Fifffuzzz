extends Node3D


const speed = 300
const duration = 5
var life = 0

func body_entered(object):
	pass

func _physics_process(delta):
	position += transform.basis.z * speed * delta
	
	life += delta
	if life >= duration:
		get_tree().get_node("ProjectileManager").give_projectile(self)

