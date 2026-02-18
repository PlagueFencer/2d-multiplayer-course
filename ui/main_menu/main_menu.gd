extends Control
const PORT: int = 3000
const ADDRESS : String = "127.0.0.1"

# NOTE: starting atleast from 4.6.1 the scene contains automatically these
# references if added from the Signals-tab
@onready var host_button: Button = $HBoxContainer/VBoxContainer/HostButton
@onready var join_button: Button = $HBoxContainer/VBoxContainer/JoinButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)
	multiplayer.peer_connected.connect(_on_peer_connected)
	
func _on_peer_connected(id: int) -> void:
	print("my peer id: %s" % multiplayer.get_unique_id())
	print("peer connected %s" % id)

func _on_host_pressed() -> void:
	var server_peer := ENetMultiplayerPeer.new()
	server_peer.create_server(PORT)
	multiplayer.multiplayer_peer = server_peer
	
func _on_join_pressed() -> void:
	var client_peer := ENetMultiplayerPeer.new()
	client_peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = client_peer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
