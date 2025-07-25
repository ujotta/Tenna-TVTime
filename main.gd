extends Node

@onready var faces: AnimatedSprite2D = $Channels/Main/Faces
@onready var timer: Timer = $Channels/Main/Timer
@onready var talk: AudioStreamPlayer = $Channels/Main/Talk

@onready var transition: Node2D = $Transition

var time : float = .3
var rot : float = 0.0
var rot2 : float = 0.0
@export var rotmax : int = 10

enum Channels {
	MAIN,
	WEATHER,
	OPTIONS,
	CHALLENGE
}
var channel : Channels = Channels.MAIN
var current_channel: Node2D

# channel cheat sheet
# (yes i know this is unnecessary im just making a reference to a very genius person)
# 0: Main 
# 1: weather 
# 2: physical challenges
# 3: configs 

func _ready() -> void:
	current_channel = $Channels/Main
	$Channels.position.x = int(get_viewport().get_visible_rect().size.x /2) - ProjectSettings.get_setting("display/window/size/viewport_width") / 2
	transition.position.x = $Channels.position.x
	Input.set_custom_mouse_cursor(preload("res://img/UI/cursor2.png"))
	timer.timeout.connect(_on_timer_timeout)
	faces.play()
	talk.play()
	talk.stream_paused = true

# TODO: Channels and channel transition

func _process(delta: float) -> void:
	get_tree().root.transparent_bg = false
	
	handle_input(delta)
	if channel < 0:
		channel = Channels.size() - 1
	elif channel > Channels.size() - 1:
		channel = 0
	match channel:
		Channels.MAIN: # TODO: Configure AI API
			current_channel = $Channels/Main
			rot += 1 * delta
			rot2 += 2 * delta
			faces.position.x = 200 + Vector2(10, 0).rotated(rot).x
			faces.position.y = 150 + Vector2(5, 0).rotated(rot2).y
			faces.rotation = deg_to_rad(Vector2(rotmax, 0).rotated(rot).x)

			if Input.is_action_just_pressed("ui_up"):
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

			faces.speed_scale = 0
			if !talk.stream_paused:
				faces.speed_scale = 1
		Channels.WEATHER: # TODO: everything
			current_channel = $Channels/Weather
		Channels.OPTIONS: # TODO: everything
			current_channel = $Channels/Options
		Channels.CHALLENGE: # TODO: everything
			current_channel = $Channels/Challenge
	current_channel.visible = true

func handle_input(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		transition.play()
		current_channel.visible = false
		channel -= 1
	elif Input.is_action_just_pressed("ui_right"):
		transition.play()
		current_channel.visible = false
		channel += 1
		

func _on_timer_timeout() -> void:
	talk.stream_paused = true
