extends Node2D

@export var boid_scene: PackedScene
@export var num_boids = 10
@export var max_angular_speed = 5
@export var is_seperation = false
@export var is_allignment = false
@export var is_cohesion = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(num_boids):
		var boid = boid_scene.instantiate()
		boid.set_rules(is_seperation, is_allignment, is_cohesion)
		boid.set_max_angular_speed(max_angular_speed)
		add_child(boid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
