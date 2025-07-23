extends Node

var timer : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(preload("res://img/UI/cursor2.png"))
	$Control/AnimatedSprite2D.position.x = int(get_viewport().get_visible_rect().size.x /2)
	$Control/ColorRect2.material.set_shader_parameter("progress", -.25)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer && !$Control/ColorRect2.material.get_shader_parameter("progress") >= 1.1:
		$Control/ColorRect2.material.set_shader_parameter("progress",$Control/ColorRect2.material.get_shader_parameter("progress") + delta / 4)
	elif $Control/ColorRect2.material.get_shader_parameter("progress") >= 1.1:
		get_tree().change_scene_to_file("res://main.tscn")

func start() -> void:
	timer = true
