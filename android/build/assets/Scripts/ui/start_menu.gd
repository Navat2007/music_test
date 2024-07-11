extends Control

@export var start_button: Button
@export var quit_button: Button

var scene_manager: SceneManager

func _ready() -> void:
	scene_manager = ServiceLocator.SceneManagerInstance as SceneManager

	start_button.pressed.connect(_on_start_button_pressed);
	#quit_button.pressed.connect(_on_quit_button_pressed);

func _on_start_button_pressed() -> void:
	scene_manager.load_level_by_index(scene_manager.Levels.Main);

func _on_quit_button_pressed() -> void:
	get_tree().quit()
