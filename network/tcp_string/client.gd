extends Node

const ip: String = '127.0.0.1'
const port: int = 8087
const TAG: String = '[Client]: '

var client = StreamPeerTCP.new()

func _ready():
	client.connect_to_host("127.0.0.1",8087)
	if client.is_connected_to_host():
		var body = KxMessage.TestMessage.new()
		body.foo = 999
		body.bar = 'hello world'
		var body_bytes = to_json(body.to_dict()).to_utf8()
		
		var head = KxMessage.RequestHead.new()
		head.body_length = body_bytes.size()
		head.body_type_id = 16
		head.message_id = 32
		
		var head_bytes = to_json(head.to_dict()).to_utf8()
		
		print(TAG, 'head_length: ', head_bytes.size())
		print(TAG, 'head_bytes: ', head_bytes)
		print(TAG, 'body_bytes: ', body_bytes)
		
		# 写入头部的大小
		client.put_32(head_bytes.size())
		# 写入头部数据
		client.put_partial_data(head_bytes)
		# 写入消息体
		client.put_partial_data(body_bytes)
