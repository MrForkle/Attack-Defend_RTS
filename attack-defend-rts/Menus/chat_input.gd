extends LineEdit

var messages = []

func _on_text_submitted(new_text: String) -> void:
	text = ""
	rpc_id(1,"add_message",new_text,"testing")

@rpc("reliable","call_remote","any_peer")
func add_message(mesg,client_name):
	if len(mesg) > 500 and mesg != "":
		return 1
	mesg = {
		"name" : client_name,
		"time" : Time.get_time_dict_from_system(),
		"message" : mesg
		}
	messages.append(mesg)
	messages = sort_messages(messages)
	var new_text = remake_text(messages)
	rpc("update_chat",new_text,messages)
	return 0

@rpc("reliable","call_local","authority")
func update_chat(new_text,new_messages):
	get_parent().get_node("PanelContainer/RichTextLabel").text = new_text
	messages = new_messages

func remake_text(passed_messages):
	var new_text = ""
	
	for i in passed_messages:
		new_text += str(i["time"]["hour"]) + ":" + str(i["time"]["minute"]) + " " + i["name"] + ": " + i["message"] + "\n"
	return new_text

func sort_messages(passed_messages):
	var stop = false
	
	while stop == false:
		for i in range(len(passed_messages)):
			stop = true
			if i == 0:
				continue
			if passed_messages[i]["time"]["hour"] < passed_messages[i-1]["time"]["hour"]:
				passed_messages.insert(i-1,passed_messages[i])
				passed_messages.pop_at(i+1)
				stop = false
				break
			if passed_messages[i]["time"]["minute"] < passed_messages[i-1]["time"]["minute"]:
				passed_messages.insert(i-1,passed_messages[i])
				passed_messages.pop_at(i+1)
				stop = false
				break
			if passed_messages[i]["time"]["second"] < passed_messages[i-1]["time"]["second"]:
				passed_messages.insert(i-1,passed_messages[i])
				passed_messages.pop_at(i+1)
				stop = false
				break
	return passed_messages
