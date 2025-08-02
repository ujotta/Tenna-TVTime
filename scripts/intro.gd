extends Node

var timer : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiscordRPC.app_id = 1401015371934208082 # Application ID
	DiscordRPC.details = "Faço programa 20 real a linha de codigo"
	DiscordRPC.state = "So to fazendo bosdta mermo :3"
	DiscordRPC.large_image = "res://img/faces/whisper.png" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Sla oq bota agui"
	DiscordRPC.small_image = "res://img/faces/whisper.png" # Image key from "Art Assets"
	DiscordRPC.small_image_text = "Abulé"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	# DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!
	
	
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("https://api.github.com/repos/ujotta/tenna-tvtime/releases/latest")
	print("current version: ", ProjectSettings.get_setting("application/config/version"))

	Input.set_custom_mouse_cursor(preload("res://img/UI/cursor2.png"))
	$Control/AnimatedSprite2D.position.x = int(get_viewport().get_visible_rect().size.x /2)
	$Control/ColorRect2.material.set_shader_parameter("progress", -.25)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer && !$Control/ColorRect2.material.get_shader_parameter("progress") >= 1.1:
		$Control/ColorRect2.material.set_shader_parameter("progress",$Control/ColorRect2.material.get_shader_parameter("progress") + delta / 4)
	elif $Control/ColorRect2.material.get_shader_parameter("progress") >= 1.1:
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func start() -> void:
	timer = true

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json : Dictionary = JSON.parse_string(body.get_string_from_utf8())
	# TODO: make a release so this doesnt fail
	#print("latest repo version: ", json["tag_name"])
