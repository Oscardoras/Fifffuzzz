extends CharacterBody3D


class_name Player

@export var hp = 10

func damage(value):
	hp -= value
