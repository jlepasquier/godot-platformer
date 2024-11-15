class_name Player
extends CharacterBody2D

@onready var movement_animations: AnimatedSprite2D = $AnimatedSprite2D
#@onready var gun_animations: AnimatedSprite2D = $gun_animations

@onready var movement_state_machine: Node = $StateMachine
#@onready var gun_state_machine: Node = $gun_state_machine
@onready var player_move_component = $PlayerMoveComponent
@onready var player_dash_component = $PlayerDashComponent

func _ready() -> void:
	movement_state_machine.init(self, movement_animations, player_move_component, player_dash_component)
	#gun_state_machine.init(self, gun_animations, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)
	#gun_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)
	#gun_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	#gun_state_machine.process_frame(delta)
