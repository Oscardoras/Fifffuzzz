extends RigidBody3D


@export var force_scale: float = 150

func _ready():
	var force_x = (randf() - 0.5) * force_scale
	var force_y = (randf() * 0.5) * force_scale
	var force_z = (randf() - 0.5) * force_scale
	constant_force = Vector3(force_x, force_y, force_z)
