extends Node
class_name KxMessage


class Head:
	# 消息体长度
	var body_length :int
	
	# 消息体类型编号
	var body_type_id :int

	# 消息号
	var message_id :int
	
	func to_dict() -> Dictionary:
		return {
			'body_length': body_length,
			'body_type_id': body_type_id,
			'message_id': message_id,
		}


class RequestHead:
	extends Head
	
	static func from_dict(dict :Dictionary) -> RequestHead:
		var head = RequestHead.new()
		head.body_length = dict.body_length
		head.body_type_id = dict.body_type_id
		head.message_id = dict.message_id
		return head
	

class ResponseHead:
	extends Head
	
	# 错误号
	var error_id :int
	
	func to_dict() -> Dictionary:
		var dict = .to_dict()
		dict.error_id = error_id
		return dict
	
	static func from_dict(dict :Dictionary) -> ResponseHead:
		var head = RequestHead.new()
		head.body_length = dict.body_length
		head.body_type_id = dict.body_type_id
		head.message_id = dict.message_id
		head.error_id = dict.error_id
		return head
		
# 测试消息
class TestMessage:
	var foo :int
	var bar :String
	
	func to_dict() -> Dictionary:
		return {
			'foo': foo,
			'bar': bar,
		}
		
	static func from_dict(dict :Dictionary) -> TestMessage:
		var body = TestMessage.new()
		body.foo = dict.foo
		body.bar = dict.bar
		return body
