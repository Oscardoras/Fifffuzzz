extends Enemy


class_name Bee

@export var hp = 1
@export var death_persistance = 10
var death_time: float = -1

func _ready():
	$Mesh/AnimationPlayer.get_animation("_bee_hover_skeletal_1").set_loop_mode(Animation.LoopMode.LOOP_LINEAR)
	$Mesh/AnimationPlayer.play("_bee_hover_skeletal_1")

func _physics_process(delta):
	if hp <= 0 and death_time < 0:
		$Mesh/AnimationPlayer.play("_bee_idle_skeletal_1")
		$AudioStreamPlayer.playing = false
		death_time = 0
	
	if death_time >= 0:
		velocity.y -= 9.8 * delta
		death_time += delta
		if death_time > death_persistance:
			queue_free()
	else:
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.playing = true
	
	move_and_slide()

func damage(value):
	hp -= value
