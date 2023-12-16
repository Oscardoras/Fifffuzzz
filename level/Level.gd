extends Node3D


var time = 0
var spawn_dispersion = 50

func random_pos():
	return -spawn_dispersion + randi() % (2*spawn_dispersion)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time >= 5:
		$EnemyManager.spawn_bee(Vector3(random_pos(), 2, random_pos()))
		time = 0
	
	$Platform/Score.text = ""
	$Platform/Score.text += "Score: " + str(get_node("/root/GameManager").score) + "\n"
	$Platform/Score.text += "HP: " + str(get_tree().get_nodes_in_group("Player")[0].hp)
