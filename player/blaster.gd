extends Node3D


@onready var ProjectileManager = get_tree().get_root().get_node("Level/ProjectileManager")

@export var delay = 0.5
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta

func shoot():
	if time > 0:
		return
	
	$AudioStreamPlayer.playing = true
	var p: XRController3D = get_parent()
	p.trigger_haptic_pulse("haptic", 10, 1, 0.1, 0)
	ProjectileManager.get_projectile(global_position + global_basis.z * 0.5, global_rotation)
	time = delay
