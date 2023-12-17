extends Area3D


class_name Projectile

@export var speed = 100
@export var duration = 1
@export var damages = 10
var life = 0

func body_entered(object):
	if object is Enemy:
		object.damage(damages)
	
	get_parent().give_projectile(self)

func _physics_process(delta):
	position += transform.basis.z * speed * delta
	
	if life >= 0:
		life += delta
		if life >= duration:
			get_parent().give_projectile(self)

