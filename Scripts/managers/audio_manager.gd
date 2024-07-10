class_name AudioManager
extends Node

@export var audioPlayer: AudioStreamPlayer;
@export var musicPlayer: AudioStreamPlayer;

@export var ui_audio: Dictionary = {
	"click": preload("res://assets/audio/ui/click3.ogg"),
	"switch": preload("res://assets/audio/ui/switch2.ogg"),
};

@export var music_list: Dictionary = {
	"default": preload("res://Audio"),
};

func _init():
	ServiceLocator.AudioManagerInstance = get_node(".");

func play_audio(clipName: String, dictionary: Dictionary):
	var clip = dictionary.get(clipName);
	
	if clip != null:
		audioPlayer.stream = clip;   
		audioPlayer.play();

func play_music(music_clip: AudioStream = music_list.get("default")):
	musicPlayer.stream = music_clip;
	musicPlayer.play();

