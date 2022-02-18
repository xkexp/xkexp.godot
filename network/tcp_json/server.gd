extends Node

const PORT := 8087
const TAG := '[Server]: '

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
		if client.get_status() != StreamPeerTCP.STATUS_CONNECTED:
			return
		var length = client.get_available_bytes()
		# 有可读数据
		if length > 0:
			# 数据长度
			print(TAG, client, ': data.len: ', length)
			# 读取消息头部长度
			var head_length = client.get_32()
			print(TAG, client, ': head_length: ', head_length)
			if client.get_available_bytes() < head_length:
				continue
			# 读取消息头
			var head_data = client.get_data(head_length)
			if head_data[0] != OK:
				continue
			var head_bytes :PoolByteArray = head_data[1]
			var head_string = head_bytes.get_string_from_utf8()
			var head_dict = parse_json(head_string)
			var head := KxMessage.RequestHead.from_dict(head_dict)
			print(TAG, head, head_string)
			
			# 读取消息体
			if client.get_available_bytes() < head.body_length:
				continue
			var body_data = client.get_data(head.body_length)
			if body_data[0] != OK:
				continue
			var body_bytes :PoolByteArray = body_data[1]
			var body_string = body_bytes.get_string_from_utf8()
			var body_dict = parse_json(body_string)
			var body := KxMessage.TestMessage.from_dict(body_dict)
			print(TAG, body, body_string)
			

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
