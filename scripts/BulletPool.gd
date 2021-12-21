extends Node

class_name BulletPool

export (PackedScene) var bullet_scene

var in_use = []
var buffer = []
var system = null

func count_used():
	return len(in_use)

func count_buffered():
	return len(buffer)

func _init():
	in_use = []
	buffer = []

func get_bullet():
	if len(buffer) == 0:
		var new_bullet = instantiate()
		in_use.append(new_bullet)
		return new_bullet
	else:
		var bullet = buffer.pop_back()
		in_use.append(bullet)
		return bullet

func expand(size):
	for i in range(size):
		buffer.append(instantiate())

func instantiate():
	var bullet = bullet_scene.instance()
	system.get_parent().add_child(bullet)
	bullet.set_pool(self)
	return bullet
	
func sleep(bullet):
	if bullet in in_use:
		in_use.erase(bullet)
		buffer.append(bullet)
