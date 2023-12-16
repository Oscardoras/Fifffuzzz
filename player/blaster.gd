extends Node3D


@export var delay = 0.2
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	if time > 0:
		return
	
	get_tree().get_node("ProjectileManager").get_projectile(position, rotation)
