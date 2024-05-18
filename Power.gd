extends RichTextLabel

@onready var chicken: CharacterBody2D = $Chicken



func _ready():
	set_physics_process(false)
	
func change_text(pow: String):
	clear()
	add_text(pow)

func _on_chicken_power_change(new_power):
	change_text(str(new_power))
	pass # Replace with function body.
