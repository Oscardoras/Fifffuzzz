extends Node


var available_projectiles: Array

func get_projectile(origin, rotation):
	if available_projectiles.is_empty():
		var projectile = preload("res://projectile/Projectile.tscn").instantiate()
		add_child(projectile)
		available_projectiles.push_back(projectile)
	
	var projectile: Node3D = available_projectiles.pop_back()
	projectile.set_process(true)
	projectile.position = origin
	projectile.rotation = rotation
	return projectile

func give_projectile(projectile):
	projectile.set_process(false)
	available_projectiles.push_back(projectile)
