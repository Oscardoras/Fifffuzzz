extends Node3D


@export var decoration_count = 200
@export var decoration_min_radius = 20
@export var decoration_max_radius = 100
@export var decoration_height = 500
@export var spawn_distance = 75
@export var bees_by_wave = 2
@export var wave_delay = 5
var platform_speed = 1000
var time = 0
var decoration_list = []
var died = false

# Called when the node enters the scene tree for the first time.
func _ready():
	decoration_list.append(preload("res://level/Island.tscn"))
	decoration_list.append(preload("res://level/Lotus.tscn"))
	
	for i in range(decoration_count):
		generate_decoration(randi() % decoration_height - decoration_height/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hp = get_tree().get_nodes_in_group("Player")[0].hp
	
	if not $MusicPlayer.playing:
		$MusicPlayer.playing = true
	
	$Platform/Score.text = ""
	$Platform/Score.text += "Score: " + str(get_node("/root/GameManager").score) + "\n"
	$Platform/Score.text += "HP: " + str(hp) + "\n"
	
	if hp > 0:
		time += delta
		if time >= wave_delay:
			spawn_bees()
			time = 0
	else:
		$Platform/Score.text += "GAME OVER"
		if not died:
			$GameOverSound.playing = true
		
		for enemy in $Enemies.get_children():
			enemy.queue_free()
		
		died = true

func _physics_process(delta):
	decoration_manager()
	
	$Platform.apply_force(Vector3(0, platform_speed, 0))

func get_bpm_level():
	var time = $MusicPlayer.get_playback_position()
	if time < 5:
		return 1
	elif time < 50:
		return 2
	elif time < 90:
		return 3
	elif time < 115:
		return 2
	elif time < 200:
		return 4
	else:
		return 2

func spawn_bees():
	var theta = randf() * 2*PI
	
	for i in range((bees_by_wave + randi() % bees_by_wave) * get_bpm_level()):
		var bee = preload("res://enemies/Bee.tscn").instantiate()
		
		var t = theta + randf() * 0.3
		var r = spawn_distance + randf() * 20
		bee.global_position = Vector3(r * cos(t), $Platform.position.y + randf()*20, r * sin(t))
		
		$Enemies.add_child(bee)

func decoration_manager():
	for decoration: Node3D in $Decoration.get_children():
		if decoration.position.y < $Platform.position.y - decoration_height/2:
			decoration.queue_free()
			generate_decoration($Platform.position.y + decoration_height/2)

func generate_decoration(height: float):
	var decoration: Node3D = decoration_list[randi() % decoration_list.size()].instantiate()
	
	var r = decoration_min_radius + randf() * (decoration_max_radius - decoration_min_radius)
	var theta = randf() * 2*PI
	decoration.position = Vector3(r * cos(theta), height - 25 + randf()*50, r * sin(theta))
	decoration.rotate(Vector3.UP, randf() * 2*PI)
	
	$Decoration.add_child(decoration)
