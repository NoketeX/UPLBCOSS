extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_chicken_power_change(new_power):
	if(new_power == 0):
		linear_velocity = Vector2(0, 0)
	pass # Replace with function body.
