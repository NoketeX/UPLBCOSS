extends CharacterBody2D

## Global Variables
var angle: float = 0 
var power: float = 0
@export var gravity: float
@export var friction: float

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
	move_and_collide(velocity * delta)
	velocity.x = velocity.x - friction * delta
	velocity.y = velocity.y - ((friction * delta) + (gravity * delta)) * delta
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	match State:
		CHARGING:
			if Input.is_action_pressed("LMBClick"):
				var mouse_pos: Vector2 = get_global_mouse_position()
				var pos: Vector2 = Vector2(position.x, position.y)
				# var angle: float = pos.angle_to_point(mouse_pos) * 180/PI * -1

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
				
				power = power + (delta * 100)
				power_change.emit(int(power))
				
			if Input.is_action_just_released("LMBClick"):
				angle = 0
				var mouse_pos = get_local_mouse_position()
				power = power * -1
				velocity = Vector2(mouse_pos.x * power * delta, mouse_pos.y * power * delta)
				power = 0
				
				set_physics_process(true)
				change_state.emit(FLYING)
				State = FLYING
				
		FLYING:
			if(velocity.x == 0 && velocity.y == 0):
				change_state.emit(IDLE)
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
