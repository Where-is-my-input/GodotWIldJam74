extends TileMapLayer

func removeNavigation(pos):
	set_cell(local_to_map(pos), 0, Vector2i(0,1))

func addNavigation(pos):
	set_cell(local_to_map(pos), 0, Vector2i(1,0))
