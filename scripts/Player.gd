extends Area2D

export var speed = 200
export var speed_co = 1.5
export var fire_time = 0.03
export var bullet_speed = 400
var fire_clock = 0
var mode = 0 # 0 is red, 1 is blue
onready var bullet_system : BulletSystem = get_tree().get_nodes_in_group("BulletSystem")[0]

func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if Input.is_action_just_pressed("swap"):
		if mode == 0:
			mode = 1
			$SpinBlue.play("Spin")
		else:
			mode = 0
			$SpinRed.play("Spin")
	var vel = Vector2()
	if Input.is_action_pressed("left"):
		vel.x -= 1
	if Input.is_action_pressed("right"):
		vel.x += 1
	if Input.is_action_pressed("up"):
		vel.y -= 1
	if Input.is_action_pressed("down"):
		vel.y += 1
	rotation_degrees = vel.x * 5
	if vel.length() > 0:
		vel = vel.normalized()
		vel *= speed
		if not Input.is_action_pressed("fire"):
			vel *= speed_co
		translate(vel * delta)
	
	if fire_clock < 0:
		if Input.is_action_pressed("fire") and not $SpinBlue.is_playing() and not $SpinRed.is_playing():
			fire_clock = fire_time
			var bullet : Bullet = bullet_system.get_bullet(mode)
			bullet.start(position, Vector2.UP * bullet_speed)
	else:
		fire_clock -= delta
			
