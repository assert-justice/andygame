extends Node2D

export var velocity = Vector2()

func _physics_process(delta):
	translate(velocity * delta)
