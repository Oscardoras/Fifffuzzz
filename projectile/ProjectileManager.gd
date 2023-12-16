extends Node


var available_projectiles: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_projectile(origin, rotation):
	if available_projectiles.is_empty():
		var projectile = preload("res://projectile/Projectile.tscn").instantiate()
		add_child(projectile)
		available_projectiles.push_back(projectile)
	
	var projectile: Node3D = available_projectiles.pop_back()
	#projectile.set_process(true)
	projectile.position = origin
	projectile.rotation = rotation
	return projectile

func give_projectile(projectile):
	#projectile.set_process(false)
	available_projectiles.push_back(projectile)
