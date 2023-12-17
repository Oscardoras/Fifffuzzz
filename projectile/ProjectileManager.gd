extends Node


var available_projectiles: Array

func get_projectile(origin, rotation):
	if available_projectiles.is_empty():
		var projectile = preload("res://projectile/Projectile.tscn").instantiate()
		available_projectiles.push_back(projectile)
		add_child(projectile)
	
	var projectile: Node3D = available_projectiles.pop_back()
	projectile.life = 0
	projectile.position = origin
	projectile.rotation = rotation
	projectile.set_process(true)
	projectile.get_node("MeshInstance").visible = true
	return projectile

func give_projectile(projectile):
	projectile.get_node("MeshInstance").visible = false
	projectile.set_process(false)
	projectile.life = -1
	available_projectiles.push_back(projectile)
