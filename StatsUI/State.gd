extends Node2D

#другое
var rng = RandomNumberGenerator.new()

#статы_персонажа
@export var player_class : Resource
var player_name : String
var lvl = 1
var gold = 1
var current_health = 19
var max_health : int
var damage = 10
var current_armor = load("res://inventory/items/leather_armor.tres")
var current_weapon = load("res://inventory/items/axe.tres")
var current_access : Resource
var current_act : String
var inv = []
#вспомогательные переменные
var bar_not_enter = false
var check : int
var loot = false
var weapon = false
var access = false
var armor = false
var weapon_new_axe = false
var elf_access = false
var quest4act = false
var enter_storage = false
@export var item : Resource


@export var current_enemy : String
# 1 акт враги
var wolf1act = true
var raven1act = true
var slime1act = true
var druid1act = true
var bard1act = true
var elder1act = true
var boss1act = true

# акт 2 враги
var bosskobold2act = true
var kobold2act = true
var bossdragon2act = true

# акт 3 враги
var dragonborn = true
var oldman = true
var girl = true
var fisher = true
var guard1 = true
var guard2 = true

# акт 4 враги
var druid_daughter = true
var elf = true
var shopman = true
var advertiser = true
var beggar = true
var boss4actlibrarian = true
var lib_guard = true

func _ready():
	player_class = load("res://tres/barbarian.tres")
	max_health = player_class.max_health
	lvl = 1
  
func _process(delta):
	set_weapon()
	set_access()
	set_armor()
	set_new_axe_weapon()
  

func set_new_axe_weapon():
	if weapon_new_axe == false:
		return
	elif weapon_new_axe == true:
		State.current_weapon = load("res://inventory/items/new_axe.tres")

func set_weapon():
	if weapon == false:
		return
	elif weapon == true:
		State.current_weapon = load("res://inventory/items/axe.tres")


func set_access():
	if access == false:
		return
	elif access == true:
		State.current_access = load("res://inventory/items/ring.tres")
		player_class.intelligence = 10

func set_armor():
	if armor == false:
		return
	elif armor == true:
		State.current_armor = load("res://inventory/items/leather_armor.tres")
	
	
func check_dexterity():
	var mod = (player_class.dexterity - 10)/2
	check = rng.randi_range(1, 20) + mod
	return check

func go_to_battle():
	get_tree().change_scene_to_file("res://combat/combat_system.tscn")
  
func guitar_melody():
	SoundPlayer.play_sound("acoustic-guitar-melody.wav")

func barking():
	SoundPlayer.play_sound("barking.wav")
  
func inv_signal():
	loot = true
	return loot
  




func heal_cookie():
	item = load("res://inventory/items/Cookie.tres")
	State.current_health += item.health_restored
	if State.current_health > State.max_health:
		State.current_health = State.max_health
	
	
func heal_candy():
	item = load("res://inventory/items/small_candy.tres")
	State.current_health += item.health_restored
	if State.current_health > State.max_health:
		State.current_health = State.max_health
	
func heal_carrot():
	item = load("res://inventory/items/carrot.tres")	
	State.current_health += item.health_restored
	if State.current_health > State.max_health:
		State.current_health = State.max_health
		
func set_axe():
	weapon_signal()

func set_ring():
	access_signal()

func set_leather():
	armor_signal()
	
func set_new_axe():
	weapon_new_axe = true
	return weapon_new_axe
  
func weapon_signal():
	weapon = true
	return weapon

func access_signal():
	access = true
	return access

func armor_signal():
	armor = true
	return armor

func minus_gold(g : int):
	State.gold = max(0, State.gold-g)
	return State.gold

func go_to_second_act():
	change_act_siganl()
	get_tree().change_scene_to_file("res://act_2.tscn")
	lvl_up()
	damage_up()
	max_hp_up()
	
func go_to_third_act():
	change_act_siganl()
	get_tree().change_scene_to_file("res://act_3.tscn")
	lvl_up()
	damage_up()
	max_hp_up()

func go_to_bar():
	bar = true
	return bar
	
func go_to_village():
	village = true
	return village

func enter_to_bar():
	enter_bar = true
	return enter_bar

var enter_bar = false
var village = false
var bar = false
var first_enter = false
var library_enter = false
var library_exit = false
var carrot = false
var new_axe = false

func change_act_siganl():
	first_enter = true 
	return first_enter
	
func get_gold(g:int):
	gold += g
	return gold

func lvl_up():
	lvl += 1
	return lvl
	
func damage_up():
	damage += 10
	return damage
	
func max_hp_up():
	max_health += 20
	return max_health

func buy_food_in_bar():
	gold -= 10
	current_health = max_health
	return current_health

func go_to_fourth_act():
	change_act_siganl()
	get_tree().change_scene_to_file("res://act_4.tscn")
	lvl_up()
	damage_up()
	max_hp_up()

func go_to_library():
	library_enter = true
	return library_enter

func exit_library():
	library_exit = true
	return library_exit
	
func buy_carrot():
	gold -= 50
	carrot = true
	return carrot
	
func buy_new_axe():
	gold -= 300
	new_axe = true
	return new_axe
	
var jail = false
var mem = false
var move = false

func jail_no_mem():
	jail = true
	mem = false
	get_tree().change_scene_to_file("res://bad_end.tscn")

func jail_mem():
	jail = true
	mem = true
	get_tree().change_scene_to_file("res://bad_end.tscn")

func town_no_mem():
	jail = false
	mem = false
	get_tree().change_scene_to_file("res://good_end.tscn")
	
func town_mem():
	jail = false
	mem = true
	get_tree().change_scene_to_file("res://good_end.tscn")
