extends Enemy


class_name Bee

@export var hp: int = 1
@export var persistance: float = 20
@export var xp: int = 10
@export var speed: float = 50
@export var damages: int = 1
@export var horizontal_rotation_speed = 0.5
@export var vertical_rotation_speed = 2
@export var one_attack = true
var alive = true
var time: float = 0

func _ready():
	$Mesh/AnimationPlayer.get_animation("_bee_hover_skeletal_1").set_loop_mode(Animation.LoopMode.LOOP_LINEAR)
	$Mesh/AnimationPlayer.play("_bee_hover_skeletal_1")
	
	var direction = get_tree().get_nodes_in_group("Player")[0].global_position + Vector3.UP - global_position
	look_at(direction)

func _physics_process(delta):
	if hp <= 0 and alive:
		$Mesh/AnimationPlayer.play("_bee_idle_skeletal_1")
		$AudioStreamPlayer.playing = false
		get_node("/root/GameManager").score += xp
		alive = false
		time = 0
	
	if not alive:
		gravity_scale = 1
	else:
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.playing = true
		
		move(delta)
	
	time += delta
	if time > persistance:
		queue_free()

func move(delta):
	var direction = get_tree().get_nodes_in_group("Player")[0].global_position + Vector3.UP - global_position
	direction /= direction.length()
	
	apply_force(-global_transform.basis.z * speed)
	
	if not one_attack or global_transform.basis.z.dot(direction) < 0:
		if global_transform.basis.x.dot(direction) > 0:
			rotate(Vector3.UP, - horizontal_rotation_speed * delta)
		else:
			rotate(Vector3.UP, horizontal_rotation_speed * delta)
		
		if global_transform.basis.y.dot(direction) > 0:
			rotate(global_transform.basis.x, vertical_rotation_speed * delta)
		else:
			rotate(global_transform.basis.x, - vertical_rotation_speed * delta)


func body_entered(object):
	if object is Player:
		object.damage(damages)

func damage(value):
	hp -= value
