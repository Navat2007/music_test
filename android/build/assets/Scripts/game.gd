class_name Game
extends Node

@export var gui_container: CanvasLayer;
@export var level_container: Node2D;

var is_exit_saved: bool = false;

func _init() -> void:
	EventBus.on_cycle_tick.connect(_on_cycle_tick)
	ServiceLocator.GameInstance = get_node(".");
	Storage.load_all();

func _ready() -> void:
	ServiceLocator.SceneManagerInstance.load_main_menu();
	get_tree().auto_accept_quit = false;

func _on_cycle_tick() -> void:
	print("Cycle tick")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		Storage.save_all();
		is_exit_saved = true;
		get_tree().quit();
	elif what == NOTIFICATION_WM_CLOSE_REQUEST:
		Storage.save_all();
		is_exit_saved = true;
		get_tree().quit();

func _exit_tree():
	print("exit");

	if not is_exit_saved:
		Storage.save_all();
