extends Node

var server = TCP_Server.new()


func _ready():
	server.listen(8087, "127.0.0.1")


func _process(delta):
	if server.is_listening():
		var socket = server.take_connection()
		if socket:
			print('[Server]: ', socket, 'Said: ', socket.get_var())
