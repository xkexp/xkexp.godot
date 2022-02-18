extends Node

# 新建一个Server
var server = TCP_Server.new()


func _ready():
	# 开始对指定的端口进行监听
	server.listen(8087, "127.0.0.1")


func _process(delta):
	# 监听
	if server.is_listening():
		# 如果有连接上来的客户端,就取出来
		var socket = server.take_connection()
		# 尝试读取客户端的数据
		if socket:
			print('[Server]: ', socket, 'Said: ', socket.get_var())
