extends Control

@export var home_button: Button
@export var settings_button: Button
@export var info_button: Button

var scene_manager: SceneManager

func _ready() -> void:
	scene_manager = ServiceLocator.SceneManagerInstance as SceneManager

	home_button.pressed.connect(_on_home_button_pressed);
	settings_button.pressed.connect(_on_settings_button_pressed);
	info_button.pressed.connect(_on_info_button_pressed);


func _on_home_button_pressed() -> void:
	scene_manager.load_main_menu();

func _on_settings_button_pressed() -> void:
	pass
	
func _on_info_button_pressed() -> void:
	pass
