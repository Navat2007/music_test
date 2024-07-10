class_name Character
extends Node2D

@export var audio_player: AudioStreamPlayer;
@export var animation_player: AnimationPlayer;
@export var animated_sprite: AnimatedSprite2D;
@export var music_clip: AudioStream;
@export var click_area: Area2D;
enum States {
    Idle,
    Play,
    Ready
};
var current_state: int = States.Idle;


func _ready() -> void:
    click_area.input_event.connect(_on_click_area_input_event);
    EventBus.on_cycle_tick.connect(_on_cycle_tick);
    audio_player.stream = music_clip;


func _on_click_area_input_event(_viewport, event, _shape_idx) -> void:
    if event is InputEventMouseButton and event.pressed:
        match current_state:
            States.Idle:
                current_state = States.Ready
                animated_sprite.play("ready")
            States.Play:
                current_state = States.Idle
                animated_sprite.play("idle")
                audio_player.stop()
            States.Ready:
                current_state = States.Idle
                animated_sprite.play("idle")
                audio_player.stop()


func _on_cycle_tick() -> void:
    match current_state:
        States.Idle:
            pass
        States.Play:
            audio_player.play()
        States.Ready:
            current_state = States.Play
            animated_sprite.play("play")
            audio_player.play()

