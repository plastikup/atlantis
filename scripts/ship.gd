extends CharacterBody2D

@export var max_speed: float = 300.0
@export var accel: float = 900.0
@export var friction: float = 300.0

@export var max_turn_speed: float = 2.5
@export var turn_accel: float = 10.0
@export var turn_friction: float = 4.0

var _turn_rate: float = 0.0

func _ready() -> void:
	PlayerInfo.radarElements.append({"type" : "player", "node" : self}) 

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("up", "down") 
	var turn := Input.get_axis("left", "right")
	
	# you either want to go to max turn rate (negative or positive) or no turn rate
	var target_turn_rate := turn * max_turn_speed 
	
	# you look if you want to decrease with friction or increase with acceleration
	var turn_rate_dif := (turn_accel if turn else turn_friction) * delta 
	
	# you set up the turn rate by increasing (or decreasing) with turn_rate_dif 
	# however move_towards function limits going over the target_turn_rate
	_turn_rate = move_toward(_turn_rate, target_turn_rate, turn_rate_dif) 
	rotation += _turn_rate * delta

	# you rotate the vector and add the max speed (negative or positive) or no speed
	var forward := Vector2.RIGHT.rotated(rotation)
	var desired_velocity: Vector2
	if direction:
		desired_velocity = forward.normalized() * (direction * max_speed)
	else:
		desired_velocity = forward.normalized() * (-abs(turn) * max_speed) / 2

	# you set up the turn rate by increasing (or decreasing) with dif_dir 
	# however move_towards function limits going over the desired_velocity
	var dif_dir := (accel if direction != 0.0 else friction) * delta
	velocity = velocity.move_toward(desired_velocity, dif_dir)
	move_and_slide()
	
