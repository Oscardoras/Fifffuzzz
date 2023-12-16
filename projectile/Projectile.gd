extends Area3D


class_name Projectile

@onready var ProjectileManager = get_tree().get_root().get_node("Level/ProjectileManager")

@export var speed = 100
@export var duration = 1
@export var damages = 10
var life = 0

func body_entered(object):
	if object is Enemy:
		object.damage(damages)
	
	ProjectileManager.give_projectile(self)

func _physics_process(delta):
	position += transform.basis.z * speed * delta
	
	life += delta
	if life >= duration:
		ProjectileManager.give_projectile(self)

