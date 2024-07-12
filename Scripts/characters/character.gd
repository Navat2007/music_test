class_name Character extends Node2D

@export var audio_player: AudioStreamPlayer;
@export var music_clip: AudioStream;
@export var click_area: Area2D;

@onready var dragonbones:DragonBones = $DragonBones;
@onready var _armature :DragonBonesArmature = dragonbones.armature

enum States {
    Idle,
    Play,
    Ready
};

var current_state: int = States.Idle;
var total_frames: int = 96;
var time_per_frame: float = Global.cycle_tick / total_frames;

func _ready() -> void:
    click_area.input_event.connect(_on_click_area_input_event);
    EventBus.on_cycle_tick.connect(_on_cycle_tick);

    if music_clip:
        audio_player.stream = music_clip;
    else:
        print("No music clip provided for character: ", name);

    _armature.current_animation = "idle";
    modulate = Color(0.176, 0.176, 0.176, 0.812);

func _on_click_area_input_event(_viewport, event, _shape_idx) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        _armature.stop(_armature.current_animation, true)

        match current_state:
            States.Idle:
                current_state = States.Ready;
                modulate = Color(1.0, 1.0, 1.0, 1.0);

                #var start_frame: int = floori(Global.cycle_elapsed / time_per_frame) % total_frames;
                var start_progress: float = Global.cycle_elapsed / time_per_frame / 100;

                _armature.play_from_progress("ready", start_progress);
            States.Play:
                current_state = States.Idle;
                _armature.play("idle");
                modulate = Color(0.176, 0.176, 0.176, 0.812);
                audio_player.stop()
            States.Ready:
                current_state = States.Idle;
                _armature.play("idle");
                modulate = Color(0.176, 0.176, 0.176, 0.812);
                audio_player.stop()

func _on_cycle_tick() -> void:
    match current_state:
        States.Idle:
            pass;
        States.Play:
            audio_player.play();
        States.Ready:
            current_state = States.Play;
            _armature.play("play");
            audio_player.play();
