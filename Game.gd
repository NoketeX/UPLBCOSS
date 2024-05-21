extends Node2D

enum {CHARGING, FLYING, IDLE}
var PlayerState

@onready var camera: Camera2D = $Camera2D
@onready var chicken: CharacterBody2D = $Chicken
@onready var power: RichTextLabel = $Power
@onready var window : Window = get_window()
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
			camera.position = chicken.position
		FLYING: 
			camera.zoom = Vector2(1, 1)
			camera.position = Vector2(0,0)
			power.position = Vector2(-16, -window.size.y/2)
		IDLE: 
			camera.zoom = Vector2(3, 3)
			camera.position = chicken.position
			power.position = Vector2(camera.position.x + 20, camera.position.y + 20)
		
