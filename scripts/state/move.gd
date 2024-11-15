extends State

@export var dash_state: State
@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func process_input(event: InputEvent) -> State:
	if dash_component.can_dash():
		return dash_state
	return null

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		dash_component.restore_dashes()
	
	if get_jump() and parent.is_on_floor():
		return jump_state

	parent.velocity.y += gravity * delta

	var movement = get_movement_input() * move_speed
	
	if movement == 0:
		return idle_state
	
	animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
