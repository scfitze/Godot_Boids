extends CanvasLayer

signal allignemnt
signal cohesion
signal seperation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cohesion_button_toggled(toggled_on):
	cohesion.emit()


func _on_seperation_button_toggled(toggled_on):
	seperation.emit()


func _on_allignment_button_toggled(toggled_on):
	allignemnt.emit()
