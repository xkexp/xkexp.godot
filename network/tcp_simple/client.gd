extends Node

const ip: String = '127.0.0.1'
const port: int = 8087
const tag: String = '[Client]: '

var client = StreamPeerTCP.new()

func _ready():
	client.connect_to_host("127.0.0.1",8087)
	if client.is_connected_to_host():
		client.put_var("hello world!")
