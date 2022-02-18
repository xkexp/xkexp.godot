extends Node

const PORT := 8087
const TAG := '[Server]: '
const KxMessage = preload("res://scripts/kx_messages.gd")

var server: TCP_Server
var clients : Array = [] # StreamPeerTCP[]


func _ready():
	start()


func _process(delta):
	# 如果有新的客户端连接过来,则保存起来
	if server.is_connection_available():
		clients.push_back(server.take_connection())
	
	for c in clients:
		var client :StreamPeerTCP = c as StreamPeerTCP
		# 需要连接可用
		if client.get_status() != StreamPeerTCP.STATUS_CONNECTED:
			return
		# 需要有可读数据
		if client.get_available_bytes() <= 0:
			return
		var message_length :int = client.get_32()
		# 需要数据整包
		if client.get_available_bytes() < message_length:
			return
		var message_data = client.get_data(message_length)
		# 读取失败 TODO:异常处理
		if message_data[0] != OK:
			return
		var message := KxMessage.TestMessage.new()
		# 读取失败 TODO:异常处理
		if message.from_bytes(message_data[1]) != KxMessage.PB_ERR.NO_ERRORS:
			return
		print(TAG, message)
		print(TAG, 'foo: ', message.get_foo(), ', bar: ', message.get_bar())


func _exit_tree():
	stop()


# 启动服务
func start():
	server = TCP_Server.new()
	var success = server.listen(PORT)
	if success != OK:
		print(TAG, '服务器监听失败: ', success)
	else:
		print(TAG, '等待客户端连接, 端口: ', PORT)
	
	
# 关闭服务
func stop():
	# 断开所有客户端
	for client in clients:
		client.disconnect_from_host()
	# 关闭服务
	server.stop()
