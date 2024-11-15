extends State

@export var move_state: State
@export var fall_state: State
@export var idle_state: State

@export var dash_duration := 0.2

var dash_timer := 0.0
var direction := 1.0


@onready var ghost_trail: Node2D = $GhostTrail


func enter() -> void:
	super()
	dash_timer = dash_duration
	direction = get_direction()
	parent.velocity.x = direction * move_speed
	parent.velocity.y = 0
	ghost_trail.start(parent)
	
	
func exit() -> void:
	super()
	ghost_trail.stop()


# Just to be safe, disable any other inputs
func process_input(event: InputEvent) -> State:
	return null


func process_physics(delta: float) -> State:
	dash_timer -= delta
	
	if dash_timer <= 0.0:
		return on_dash_over()
	else:
		return while_still_dashing(delta)


func on_dash_over():
	if !parent.is_on_floor():
		return fall_state
	if Input.get_axis('move_left', 'move_right') != 0.0:
		return move_state
	return idle_state


func while_still_dashing(delta):
	if parent.velocity.x == 0:
		return idle_state
	parent.move_and_slide()


# Override movement inputs
func get_movement_input() -> float:
	return direction


func get_jump() -> bool:
	return false


func get_direction() -> int:
	if animations.flip_h:
		return -1
	else:
		return 1
