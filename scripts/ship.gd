extends CharacterBody2D

@export var max_speed: float = 300.0
@export var accel: float = 900.0
@export var friction: float = 300.0

@export var max_turn_speed: float = 2.5
@export var turn_accel: float = 10.0
@export var turn_friction: float = 4.0

var menu_popup:= true

var _turn_rate: float = 0.0

var upgraded_speed: float
var upgraded_accel: float
var upgraded_friction: float

var upgraded_turn_speed: float
var upgraded_turn_accel: float
var upgraded_turn_friction: float

var initial_position = Vector2(-12288, -18432)

func _ready() -> void:
	PlayerInfo.playerNode = self
	signalHub.ship_upgraded.connect(update_ship_material)
	update_ship_material()
	signalHub.speed_upgrade.connect(onSpeedUpgraded)
	signalHub.menu.connect(menu_shown)
	signalHub.menu_hidden.connect(menu_hide)
	
	signalHub.reload_scene.connect(reset_position_and_stats)
	
	upgraded_speed = max_speed
	upgraded_turn_speed = max_turn_speed

## Updates ship's material and returns the current level of the ship

func update_ship_material() -> int:
	var newLevel = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
	print(PlayerInfo.level_to_name[newLevel])
	%AnimatedSprite2D.play(PlayerInfo.level_to_name[newLevel])
	return newLevel

func menu_shown() -> void:
	menu_popup = true
	
func menu_hide() -> void:
	menu_popup = false
	
func onSpeedUpgraded() -> void: 
	var type = PlayerInfo.upgrade_types.SPEED
	upgraded_speed = max_speed * (1 + PlayerInfo.upgrade_level_values[type][PlayerInfo.player_upgrade_levels[type]] / 100.0)
	upgraded_accel = accel * (1 + PlayerInfo.upgrade_level_values[type][PlayerInfo.player_upgrade_levels[type]] / 100.0)
	upgraded_friction = friction * (1 + PlayerInfo.upgrade_level_values[type][PlayerInfo.player_upgrade_levels[type]] / 100.0)
	
	upgraded_turn_speed = max_turn_speed * (1 + PlayerInfo.upgrade_level_values[type][PlayerInfo.player_upgrade_levels[type]] / 100.0)
	upgraded_turn_accel = turn_accel * (1 + PlayerInfo.upgrade_level_values[type][PlayerInfo.player_upgrade_levels[type]] / 100.0)
	upgraded_turn_friction = turn_friction * (1 + PlayerInfo.upgrade_level_values[type][PlayerInfo.player_upgrade_levels[type]] / 100.0)
	
	print(max_speed, upgraded_speed)

func _physics_process(delta: float) -> void:
	if not menu_popup:
		var direction := Input.get_axis("up", "down") 
		var turn := Input.get_axis("left", "right")
		
		var level = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
		if direction or turn:
			%AnimatedSprite2D.play(PlayerInfo.level_to_name[level])
			if !$motor.playing:
				$motor.play()
		else :
			%AnimatedSprite2D.stop()
			$motor.stop()
			
		
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
			desired_velocity = forward.normalized() * (direction * upgraded_speed)
		else:
			desired_velocity = forward.normalized() * (-abs(turn) * upgraded_speed) / 2

		# you set up the turn rate by increasing (or decreasing) with dif_dir 
		# however move_towards function limits going over the desired_velocity
		var dif_dir := (accel if direction != 0.0 else friction) * delta
		velocity = velocity.move_toward(desired_velocity, dif_dir)
		move_and_slide()
		
		
func reset_position_and_stats() -> void:
	position = initial_position
	PlayerInfo.fish_inv = [0,0,0,0]
	PlayerInfo.shipHealth = PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][0]
