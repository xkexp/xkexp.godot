extends Node

const SERVER_IP: String = '127.0.0.1'
const SERVER_PORT: int = 8087
const TAG: String = '[Client]: '

# 建立一个Client
var client = StreamPeerTCP.new()

func _ready():
	# 尝试连接服务器
	client.connect_to_host(SERVER_IP, SERVER_PORT)
	if client.is_connected_to_host():
		print(TAG, '连接服务器成功: ', SERVER_IP, ':', SERVER_PORT)
		client.put_var("hello world!")
