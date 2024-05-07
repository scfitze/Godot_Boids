extends Area2D

@export var speed = 600
@export var max_angular_speed = 5
var angular_speed = 0
var screen_size

var is_seperation = true
var is_allignment = true
var is_cohesion = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(randi_range(0, screen_size.x), randi_range(0, screen_size.y))
	var angle = randf_range(0, 2 * PI)
	rotation += angle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.UP.rotated(rotation)
	var boid_lst = get_overlapping_areas()
	if !boid_lst.is_empty():
		if is_seperation:
			angular_speed += direction.angle_to(seperation(boid_lst)) / delta
		if is_cohesion:
			angular_speed += direction.angle_to(cohesion(boid_lst)) / delta
		if is_allignment:
			angular_speed += direction.angle_to(allignment(boid_lst)) / delta
		angular_speed = clamp(angular_speed, -max_angular_speed, max_angular_speed)
	var velocity = direction.normalized() * speed
	rotation += angular_speed * delta
	position += velocity * delta
	angular_speed = 0
		
func set_rules(is_seperation, is_allignment, is_cohesion):
	self.is_seperation = is_seperation
	self.is_allignment = is_allignment
	self.is_cohesion = is_cohesion
	
func set_max_angular_speed(max_angular_speed):
	self.max_angular_speed = max_angular_speed
		
func allignment(boid_lst):
	var vec_sum = Vector2(0,0)
	for boid in boid_lst:
		if (is_in_view_angle(boid)):
			vec_sum += Vector2(sin(boid.global_rotation), cos(boid.global_rotation))
	vec_sum /= boid_lst.size()
	vec_sum = vec_sum.normalized()
	return vec_sum

func seperation(obj_lst):
	var direction_vec = Vector2(0,0)
	# Get vector from target to boid and divide by distance^2
	for obj in obj_lst:
		if (is_in_view_angle(obj)):
			var steer_vec = Vector2(global_position.x - obj.global_position.x, global_position.y - obj.global_position.y)
			direction_vec += steer_vec / steer_vec.length()**2
	direction_vec /= obj_lst.size()
	direction_vec = direction_vec.normalized()
	return direction_vec
	
func cohesion(obj_lst):
	var direction_vec = Vector2(0,0)
	# Get vector from boid to target and divide by distance^2
	for obj in obj_lst:
		if(is_in_view_angle(obj)):
			direction_vec += Vector2(obj.global_position.x - global_position.x, obj.global_position.y - global_position.y)
	direction_vec /= obj_lst.size()
	direction_vec = direction_vec.normalized()
	return direction_vec
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	if (position.x > screen_size.x):
		position.x = 0
	if(position.x < 0):
		position.x = screen_size.x
	if (position.y > screen_size.y):
		position.y = 0
	if (position.y < 0):
		position.y = screen_size.y

func is_in_view_angle(boid):
	var A = self.get_global_position()
	var B = boid.get_global_position()
	var AB = A.direction_to(B)
	var fA = Vector2.UP.rotated(self.get_global_rotation())
	return (AB.dot(fA) > 0)
	
