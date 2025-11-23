class_name DirectoryScenes extends ScenesValue

@export_dir var directory

func value() -> Array[PackedScene]:
	
	var response:Array[PackedScene]
	
	var dir:DirAccess = DirAccess.open(directory)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				
				var file = load(directory + "/" + file_name)
				if file is PackedScene:
					response.append(file)
				
			file_name = dir.get_next()
	
	return response
