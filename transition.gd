extends Node2D

@onready var animatedsprite: AnimatedSprite2D = $Static
@onready var audio: AudioStreamPlayer = $Audio


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedsprite.animation_finished.connect(_on_animaiton_finished)


func play() -> void:
	visible = true
	animatedsprite.play()
	audio.play()
	

func _on_animaiton_finished() -> void:
	visible = false
	audio.stop()
