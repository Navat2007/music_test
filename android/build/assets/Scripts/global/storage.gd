extends Node

const SAVE_DIR: String = "user://save/";
const SAVE_FILE_NAME: String = "save.dat";
const SECURITY_KEY: String = "GoblinsBand.i.NoMatterHackersGetThisAnyway";

enum SaveSection {
	PLAYER,
	SETTINGS,
	GLOBALS,
	WORLD,
	QUESTS,
	LEVEL
}

var debug: bool = true;
var config: ConfigFile = ConfigFile.new();

func _ready():
	verify_save_directory(SAVE_DIR);

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path);

func get_section_name(section: SaveSection) -> String:
	return SaveSection.keys()[section];

func load(save_section: SaveSection, key: String, default_value: Variant = null) -> Variant:
	var result: int = config.load_encrypted_pass(SAVE_DIR + SAVE_FILE_NAME, SECURITY_KEY);

	if result == OK:
		return config.get_value(get_section_name(save_section), key, default_value);

	return null;

func load_all_settings() -> void:
	if debug:
		print_rich("[color=green]Loading settings...[/color]");	

	var window_mode = Storage.load(Storage.SaveSection.SETTINGS, "window_mode", DisplayServer.WINDOW_MODE_FULLSCREEN);

	if window_mode != null:
		if debug:
			print("Window mode: " + str(window_mode));
		DisplayServer.window_set_mode(window_mode);

	var window_flag = Storage.load(Storage.SaveSection.SETTINGS, "window_flag", DisplayServer.WINDOW_FLAG_BORDERLESS);

	if window_flag != null:
		if debug:
			print("Window flag: " + str(window_flag));
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, window_flag);

	var resolution = Storage.load(Storage.SaveSection.SETTINGS, "resolution", Vector2i(1920, 1080));

	if resolution != null:
		if debug:
			print("Resolution: " + str(resolution));
		DisplayServer.window_set_size(resolution);

	var volume = Storage.load(Storage.SaveSection.SETTINGS, "volume", 0.0);

	if volume != null:
		if debug:
			print("Volume: " + str(volume));
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume);

	var sfx_volume = Storage.load(Storage.SaveSection.SETTINGS, "sfx_volume", -20);

	if sfx_volume != null:
		if debug:
			print("SFX Volume: " + str(sfx_volume));
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_volume);

	var music_volume = Storage.load(Storage.SaveSection.SETTINGS, "music_volume", -30);

	if music_volume != null:
		if debug:
			print("Music Volume: " + str(music_volume));
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_volume);
	
func load_all() -> void:
	load_all_settings();

func save(save_section: SaveSection, key: String, value: Variant):
	config.set_value(get_section_name(save_section), key, value);
	config.save_encrypted_pass(SAVE_DIR + SAVE_FILE_NAME, SECURITY_KEY);

func save_all_settings() -> void:
	Storage.save(Storage.SaveSection.SETTINGS, "window_mode", DisplayServer.window_get_mode());
	Storage.save(Storage.SaveSection.SETTINGS, "window_flag", DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS));
	Storage.save(Storage.SaveSection.SETTINGS, "resolution", DisplayServer.window_get_size());
	Storage.save(Storage.SaveSection.SETTINGS, "volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")));
	Storage.save(Storage.SaveSection.SETTINGS, "sfx_volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")));
	Storage.save(Storage.SaveSection.SETTINGS, "music_volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")));

	if debug:
		print("Settings saved");

func save_all() -> void:
	save_all_settings();
