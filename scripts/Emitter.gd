extends Node2D

class_name Emitter

export var fire_time = 0.05
export var bullet_speed = 300
export var bullet_index = -1
export var can_fire = true
export (Vector2) var facing
var fire_clock = 0

onready var bullet_system : BulletSystem = get_tree().get_nodes_in_group("BulletSystem")[0]

func _physics_process(delta):
	if fire_clock < 0:
		if can_fire and bullet_index != -1:
			fire_clock = fire_time
			var bullet : Bullet = bullet_system.get_bullet(bullet_index)
			var facing_internal = facing
			if facing == Vector2.ZERO:
				facing_internal = Vector2.RIGHT.rotated(global_rotation)
			bullet.start(global_position, facing_internal.normalized() * bullet_speed)
	else:
		fire_clock -= delta
