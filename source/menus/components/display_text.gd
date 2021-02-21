extends TileMap

var text_lookup: String = "bceilmrst0123456789%:o p"

func set_text(text: String) -> void:
	for position in self.get_used_cells():
		self.set_cellv(position, TileMap.INVALID_CELL)

	var lines = text.split("\n")
	for line_index in lines.size():
		var line = lines[line_index]
		for char_index in line.length():
			var output_index = text_lookup.find(line[char_index])
			if output_index != -1:
				self.set_cell(char_index, line_index, output_index)

