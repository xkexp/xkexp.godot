extends Node


const ip: String = '127.0.0.1'
const port: int = 8087
const TAG: String = '[Client]: '
const KxMessage = preload("res://scripts/kx_messages.gd")

var client = StreamPeerTCP.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	client.connect_to_host("127.0.0.1", 8087)
	if client.is_connected_to_host():
		var message := KxMessage.TestMessage.new()
		message.set_foo(100)
		message.set_bar("hello test!")
		var message_bytes :PoolByteArray = message.to_bytes()
		
		print(TAG, 'message_length: ', message_bytes.size())
		print(TAG, 'message_bytes: ', message_bytes)
		
		# 写入消息长度
		client.put_32(message_bytes.size())
		# 写入消息
		client.put_partial_data(message_bytes)
