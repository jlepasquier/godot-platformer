class_name PlayerDashComponent
extends Node2D

var max_dashes = 1
var dashes_available = 1


func wants_dash() -> bool:
	return Input.is_action_just_pressed('dash')
	
	
func can_dash() -> bool:
	return wants_dash() && dashes_available > 0
	
	
func use_dash() -> void:
	dashes_available -= 1
	
	
func restore_dashes() -> void:
	dashes_available = max_dashes
