extends Node


var available_projectiles: Array

func get_projectile(origin, rotation):
	if available_projectiles.is_empty():
		var projectile = preload("res://projectile/Projectile.tscn").instantiate()
		available_projectiles.push_back(projectile)
		add_child(projectile)
	
	print(available_projectiles.size())
	var projectile: Node3D = available_projectiles.pop_front()
	projectile.life = 0
	projectile.position = origin
	projectile.rotation = rotation
	return projectile

func give_projectile(projectile):
	projectile.life = -1
	available_projectiles.push_back(projectile)
