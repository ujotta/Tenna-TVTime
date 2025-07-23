extends Node

@onready var faces: AnimatedSprite2D = $Faces
@onready var timer: Timer = $Timer
@onready var talk: AudioStreamPlayer = $Talk

var channels : int = 3
var channel : int = 0
var time : float = .3
var rot : float = 0.0
var rot2 : float = 0.0
@export var rotmax : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(preload("res://img/UI/cursor2.png"))
	timer.timeout.connect(_on_timer_timeout)
	faces.play()
	talk.play()
	talk.stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match channel:
		0:
			rot += 1 * delta
			rot2 += 2 * delta
			faces.position.x = 200 + Vector2(10, 0).rotated(rot).x
			faces.position.y = 150 + Vector2(5, 0).rotated(rot2).y
			faces.rotation = deg_to_rad(Vector2(rotmax, 0).rotated(rot).x)
			handle_input(delta)
			
			faces.speed_scale = 0
			if !talk.stream_paused:
				faces.speed_scale = 1
		1:
			pass # Will do this soon

func handle_input(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		print("press")
		#talk.playing = true
		talk.stream_paused = false
		#timer.wait_time += time
		if timer.is_stopped():
			timer.start()
			timer.wait_time = time
	elif Input.is_action_pressed("ui_down"):
		talk.stream_paused = false
	elif timer.is_stopped():
		talk.stream_paused = true

func _on_timer_timeout() -> void:
	talk.stream_paused = true
	print("stop")
