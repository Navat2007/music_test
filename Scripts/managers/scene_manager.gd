class_name SceneManager
extends Node

@export_group("UI scenes")
@export var main_menu_gui_scene: PackedScene = preload("res://Scenes/ui/start_menu.tscn");
@export var level_gui_scene: PackedScene = preload("res://scenes/ui/game_ui.tscn");
@export var loading_screen: PackedScene = preload("res://scenes/ui/scene_transition_screen.tscn");

@export_group("Level scenes")
@export var levels: Dictionary = {
	"village": "res://scenes/levels/village.tscn",
	"cave": "res://scenes/levels/cave.tscn"
};

enum Levels {
	None,
	Village,
	Cave,
	Crypt,
};

const level_dictionary = {
	Levels.Village: "village",
	Levels.Cave: "cave",
	Levels.Crypt: "crypt",
};

var current_level;
var game: Game;

func _init():
	ServiceLocator.SceneManagerInstance = get_node(".");
	EventBus.level_on_level_loaded.connect(_on_level_loaded);

func _ready():
	game = ServiceLocator.GameInstance;

func load_main_menu():
	_unload_gui();
	_unload_level();
	
	game.gui_container.add_child(main_menu_gui_scene.instantiate());	

func load_level(level: String):
	var scene = levels.get(level);

	if scene != null:
		current_level = level;

		_unload_gui();
		_unload_level();

		game.gui_container.add_child(loading_screen.instantiate());

		await get_tree().create_timer(1).timeout;

		var scene_resource = await load(scene).instantiate();
		
		game.level_container.add_child(scene_resource);

func load_level_by_index(level: Levels):
	load_level(level_dictionary.get(level));

func restart_current_level():
	load_level(current_level);

static func get_level_name_by_index(level: Levels) -> String:
	return level_dictionary.get(level);

func _unload_level():
	if game.level_container.get_child_count() > 0:
		game.level_container.remove_child(game.level_container.get_child(0));
		EventBus.level_on_level_unloaded.emit();

func _unload_gui():
	if game.gui_container.get_child_count() > 0:
		game.gui_container.remove_child(game.gui_container.get_child(0));
		EventBus.ui_on_ui_unloaded.emit();

func _on_level_loaded():
	_unload_gui();

	game.gui_container.add_child(level_gui_scene.instantiate());
