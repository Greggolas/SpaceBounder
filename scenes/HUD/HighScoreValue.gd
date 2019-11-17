extends Label


func save():
	var save_dict = {
		'high_score' : text
	}
	return save_dict
