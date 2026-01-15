extends Node2D
@onready var timer: Timer = $Timer
@onready var fish: AnimatedSprite2D = $Fish

var rndm_time := 0.0

@export var move_speed_px_s: float = 260.0
@export var stop_distance_px: float = 8.0
@export var roam_range_px: float = 1000.0

# Random initial position offset so multiple fish instances don't stack.
@export var spawn_range_px: float = 900.0

@export var rotate_to_target: bool = true
@export var rotation_lerp_speed: float = 10.0

# If the fish art is facing the opposite way, tweak this.
@export var facing_angle_offset_degrees: float = 0.0

var _target_global: Vector2
var _target_angle: float = 0.0

var _rng := RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_rng.randomize()
	global_position += Vector2(
		_rng.randf_range(-spawn_range_px, spawn_range_px),
		_rng.randf_range(-spawn_range_px, spawn_range_px)
	)
	_target_global = global_position
	_target_angle = rotation
	if fish != null and fish.sprite_frames != null and not fish.is_playing():
		fish.play()
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var to_target := _target_global - global_position
	if rotate_to_target and to_target.length() > 0.001:
		_target_angle = to_target.angle() + deg_to_rad(facing_angle_offset_degrees)
		var alpha := 1.0 - exp(-rotation_lerp_speed * delta)
		rotation = lerp_angle(rotation, _target_angle, alpha)

	if to_target.length() <= stop_distance_px:
		return
	global_position = global_position.move_toward(_target_global, move_speed_px_s * delta)
	



func _on_timer_timeout() -> void:
	var rndm_posx := _rng.randf_range(-roam_range_px, roam_range_px)
	var rndm_posy := _rng.randf_range(-roam_range_px, roam_range_px)
	_target_global = global_position + Vector2(rndm_posx, rndm_posy)
	# rotation toward target is handled smoothly in _process
	rndm_time = _rng.randf_range(3.0, 5.0)
	timer.wait_time = rndm_time
	timer.start()
