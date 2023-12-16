extends Node3D


func spawn_bee(pos: Vector3):
	var bee = preload("res://enemies/Bee.tscn").instantiate()
	bee.position = pos
	add_child(bee)
