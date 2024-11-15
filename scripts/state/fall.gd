extends State

@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var dash_state: State

@onready var coyote_timer: Timer = $CoyoteTimer

var can_jump = false

func enter() -> void:
	can_jump = true
	coyote_timer.start()
	

func _on_coyote_timer_timeout() -> void:
	can_jump = false


func process_input(event: InputEvent) -> State:
	if dash_component.can_dash():
		return dash_state
	return null


func process_physics(delta: float) -> State:
	if can_jump and get_jump():
		return jump_state
		
	parent.velocity.y += gravity * delta

	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
