extends RigidBody3D


@export var force_scale = 100

func _ready():
	constant_force = Vector3(randf() * force_scale, randf() * force_scale, randf() * force_scale)
