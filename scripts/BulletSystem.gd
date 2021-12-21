extends Node2D

export (Array,PackedScene) var bullet_scenes

onready var pools = []

class_name BulletSystem

func _ready():
	for scene in bullet_scenes:
		var pool = BulletPool.new()
		pool.bullet_scene = scene
		pool.system = self
		#pool.expand(10)
		pools.append(pool)

func get_bullet(idx):
	return pools[idx].get_bullet()

func _physics_process(delta):
	var used = pools[0].count_used()
	var buffered = pools[0].count_buffered()
