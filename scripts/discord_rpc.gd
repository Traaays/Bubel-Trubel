extends Node2D

func _ready():
	DiscordRPC.app_id = 1294704672464048289 # Application ID
	DiscordRPC.large_image = "iconfixed"
	DiscordRPC.large_image_text = "Bubel Trubel"

func refresh(menu):
	print(get_parent().currentLevel)
	if menu == false:
		DiscordRPC.details = ("Level " + str(get_parent().currentLevel))
	else:
		DiscordRPC.details = ("in Main Menu")
	DiscordRPC.small_image = ("skin" + str(get_parent().skin))
	DiscordRPC.refresh()

func stamp_refresh():
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()
