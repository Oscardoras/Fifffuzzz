extends Node3D


@export var decoration_count = 500
@export var decoration_min_radius = 20
@export var decoration_max_radius = 150
@export var decoration_height = 500
@export var spawn_distance = 50
@export var bees_by_wave = 5
var platform_speed = 1000
var time = 0
var decoration_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	decoration_list.append(preload("res://level/Island.tscn"))
	decoration_list.append(preload("res://level/Lotus.tscn"))
	
	for i in range(decoration_count):
		generate_decoration(randi() % decoration_height - decoration_height/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time >= 5:
		spawn_bees()
		time = 0
	
	$Platform/Score.text = ""
	$Platform/Score.text += "Score: " + str(get_node("/root/GameManager").score) + "\n"
	$Platform/Score.text += "HP: " + str(get_tree().get_nodes_in_group("Player")[0].hp)

func _physics_process(delta):
	decoration_manager()
	
	$Platform.apply_force(Vector3(0, platform_speed, 0))

func spawn_bees():
	var theta = (randi() % 360) * PI / 180
	
	for i in range(randi() % bees_by_wave):
		var bee = preload("res://enemies/Bee.tscn").instantiate()
		
		theta += randf() * 0.3
		bee.global_position = Vector3(spawn_distance * cos(theta), $Platform.position.y + randi() % 20, spawn_distance * sin(theta))
		
		$Enemies.add_child(bee)

func decoration_manager():
	for decoration: Node3D in $Decoration.get_children():
		if decoration.position.y < $Platform.position.y - decoration_height/2:
			decoration.queue_free()
			generate_decoration($Platform.position.y + decoration_height/2)

func generate_decoration(height: float):
	var decoration: Node3D = decoration_list[randi() % decoration_list.size()].instantiate()
	
	var r = decoration_min_radius + randi() % (decoration_max_radius - decoration_min_radius)
	var theta = (randi() % 360) * PI / 180
	decoration.position = Vector3(r * cos(theta), height - 25 + randi() % 50, r * sin(theta))
	decoration.rotate(Vector3.UP, (randi() % 360) * PI / 180)
	
	$Decoration.add_child(decoration)
