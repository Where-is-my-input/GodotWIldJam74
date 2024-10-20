extends Node2D
@onready var light_with_shadow = $LightWithShadow
@onready var light = $Light

var lightEnabled = true

func _ready():
	setLightState(lightEnabled)

func switch():
	lightEnabled = !lightEnabled
	setLightState(lightEnabled)

func setLightState(v):
	lightEnabled = v
	light.enabled = v
	light_with_shadow.enabled = v
