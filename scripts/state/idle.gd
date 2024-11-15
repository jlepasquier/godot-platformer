extends State

@export var dash_state: State
@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if get_jump() and parent.is_on_floor():
		return jump_state
	if get_movement_input() != 0.0:
		return move_state
	if dash_component.can_dash():
		return dash_state
	return null

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		dash_component.restore_dashes()
		
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
