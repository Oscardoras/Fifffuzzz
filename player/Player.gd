extends CharacterBody3D


class_name Player

@export var hp = 10

func damage(value):
	hp -= value
	
	get_node("../../LeftHand").trigger_haptic_pulse("haptic", 50, 0.5, 0.5, 0)
	get_node("../../RightHand").trigger_haptic_pulse("haptic", 50, 0.5, 0.5, 0)
	$DamagePlayer.playing = true
