extends Area2D

var pool : BulletPool = null
var awake = false
var velocity = Vector2()
export var damage = 1.0

class_name Bullet

func set_pool(pool):
	self.pool = pool

func start(pos, vel, damage_co = null, scale = null):
	position = pos
	velocity = vel
	rotation = Vector2.RIGHT.angle_to(velocity)
	awake = true
	visible = true

func _physics_process(delta):
	if not awake:
		return
	translate(velocity * delta)
	if position.x < -100 or position.y < -100 or position.x > 612 or position.y > 388:
		awake = false
		visible = false
		pool.sleep(self)
