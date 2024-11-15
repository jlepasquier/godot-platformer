extends Node2D


@export var min_opacity = 0.4
@export var max_opacity = 0.9

@onready var create_shadow_timer: Timer = $CreateShadowTimer
@onready var destroy_shadow_timer: Timer = $DestroyShadowTimer


var shadows: Array[AnimatedSprite2D] = []
var parent: CharacterBody2D


func start(_parent) -> void:
	parent = _parent
	create_shadow_timer.start()


func stop() -> void:
	create_shadow_timer.stop()
	destroy_shadow_timer.start()


func _on_create_shadow_timer_timeout() -> void:
	shadows.append(create_shadow(parent))
	update_shadows_opacity()


func _on_destroy_shadow_timer_timeout() -> void:
	var shadow = shadows.pop_front()
	if shadow != null:
		shadow.queue_free()
		destroy_shadow_timer.start();
	else:
		destroy_shadow_timer.stop()


func create_shadow(parent) -> AnimatedSprite2D:
	var sprite = parent.get_node('AnimatedSprite2D')
	var shadow = sprite.duplicate()
	shadow.global_position = parent.global_position + sprite.position
	parent.get_parent().add_child(shadow)
	return shadow


func update_shadows_opacity() -> void:
	for i in range(shadows.size()):
		var weight = float(i + 1)/float(shadows.size() )
		var opacity = lerp(min_opacity, max_opacity, weight)
		shadows[i].modulate = Color(1,1,1, opacity)
