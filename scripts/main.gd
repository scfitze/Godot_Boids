extends Node2D

@export var boid_scene: PackedScene
@export var num_boids = 10
@export var max_angular_speed = 50
@export var is_seperation = true
@export var is_allignment = true
@export var is_cohesion = true

var boid_container

# Called when the node enters the scene tree for the first time.
func _ready():
	
	boid_container = Node2D.new()
	add_child(boid_container)
	
	for i in range(num_boids):
		print(i)
		var boid = boid_scene.instantiate()
		boid.set_rules(is_seperation, is_allignment, is_cohesion)
		boid.set_max_angular_speed(max_angular_speed)
		boid_container.add_child(boid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_boid_rules():
	for boid in boid_container.get_children():
		if boid is Boid:
			boid.set_rules(is_seperation, is_allignment, is_cohesion)

func _on_canvas_layer_allignemnt():
	is_allignment = !is_allignment
	# loop through all boids and update rules
	update_boid_rules()
	print(is_allignment)


func _on_canvas_layer_cohesion():
	is_cohesion = !is_cohesion
	update_boid_rules()
	print(is_cohesion)


func _on_canvas_layer_seperation():
	is_seperation = !is_seperation
	update_boid_rules()
	print(is_seperation)
