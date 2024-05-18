extends CharacterBody2D

## Global Variables
var angle: float = 0 
var power: float = 0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

enum {CHARGING, FLYING, IDLE}
var State = IDLE

signal power_change(new_power)
signal change_state(state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("idle")
	set_physics_process(false)
	pass	

func _physics_process(delta):
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * 50)
			
	if(power < 25):
		velocity = Vector2(0, 0)
		power = 0
	## lerp through at 0.005th of the line
	velocity = Vector2(lerp(velocity.x, 0.00, 0.005), lerp(velocity.y, 0.00, 0.005))
	power = lerp(power, 0.00, 0.05)												
	power_change.emit(int(power))																																								
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	match State:
		CHARGING:
			if Input.is_action_pressed("LMBClick"):
				var mouse_pos: Vector2 = get_global_mouse_position()
				var pos: Vector2 = Vector2(position.x, position.y)
				var angle: float = pos.angle_to_point(mouse_pos) * 180/PI * -1

				if(angle > 0 && angle <= 90):
					sprite.flip_h = false
					sprite.play("bombastic_butt")
				elif(angle > 0 && angle <= 180):
					sprite.flip_h = true
					sprite.play("bombastic_butt")
					
				if(angle < 0 && angle >= -90):
					sprite.flip_h = false
					sprite.play("bombastic_side_eye")
				
				elif(angle < 0 && angle >= -180):
					sprite.flip_h = true
					sprite.play("bombastic_side_eye")
					print("lower left")
				
				power = power + (delta * 1000)
				power_change.emit(int(power))
				
			if Input.is_action_just_released("LMBClick"):
				angle = 0
				var mouse_pos = get_local_mouse_position().normalized()
				velocity = Vector2(position.x - mouse_pos.x * power, position.y - mouse_pos.y * power)
				set_physics_process(true)
				change_state.emit(FLYING)
				State = FLYING
				
		FLYING:
			if(velocity.x + velocity.y == 0):
				change_state.emit(IDLE)
				set_physics_process(false)
				State = IDLE
			
		IDLE:
			if Input.is_action_just_pressed("LMBClick"): 
				change_state.emit(CHARGING)
				State = CHARGING
			
			if Input.is_action_just_pressed("DOWN"):
				sprite.play("idle")
			
			if Input.is_action_just_pressed("RIGHT"):
				sprite.flip_h = false
				sprite.play("side")
			
			if Input.is_action_just_pressed("LEFT"):
				sprite.flip_h = true
				sprite.play("side")
	pass
