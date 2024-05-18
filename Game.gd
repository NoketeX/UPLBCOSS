extends Node2D

enum {CHARGING, FLYING, IDLE}
var PlayerState

@onready var camera: Camera2D = $Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_chicken_change_state(state):
	PlayerState = state
	
	match PlayerState:
		CHARGING:
			camera.zoom = Vector2(5, 5)
		FLYING: 
			camera.zoom = Vector2(1, 1)
		IDLE: 
			camera.zoom = Vector2(3, 3)
