extends Node


const ip: String = '127.0.0.1'
const port: int = 8087
const TAG: String = '[Client]: '
const Messages = preload("res://messages.gd")

var client = StreamPeerTCP.new()

func _ready():
	client.connect_to_host("127.0.0.1", 8087)
	client.big_endian = true
	if client.is_connected_to_host():
		print(TAG, '连接已连接.')
		_do_test_send()
		

func _exit_tree():
	client.disconnect_from_host()
	print(TAG, '连接已关闭.')


func _do_test_send():
	var m1 = Messages.Test1Message.new()
	m1.set_t1(199)
	var m2 = Messages.Test2Message.new()
	m2.set_t2('m2')
	
	var b1 = m1.to_bytes()
	var b2 = m2.to_bytes()
	
	var heads = Messages.MessageHeads.new()
	
	var h1 = Messages.MessageHead.new()
	h1.set_body_length(b1.size())
	h1.set_body_type_id(12)
	heads.get_heads().append(h1)
	
	var h2 = Messages.MessageHead.new()
	h2.set_body_length(b2.size())
	h2.set_body_type_id(13)
	heads.get_heads().append(h2)
	
	var bs = heads.to_bytes()
	
	client.put_32(bs.size())
	client.put_partial_data(bs)
	client.put_partial_data(b1)
	client.put_partial_data(b2)
	
