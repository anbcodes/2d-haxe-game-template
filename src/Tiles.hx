using Lambda;

typedef Layer = {
	name:String,
	_eid:String,
	offsetX:Int,
	offsetY:Int,
	gridCellWidth:Int,
	gridCellHeight:Int,
	gridCellsX:Int,
	gridCellsY:Int,
	tileset:String,
	data2D:Array<Array<Int>>,
	exportMode:Int,
	arrayMode:Int
}


class Tiles extends Entity {
    var layer: Layer;
    var tileGroup: h2d.TileGroup;
	var tiles: Array<h2d.Tile>;

    public function new(scene: h2d.Scene, world: echo.World, layer: Layer, tileImage: h2d.Tile) {
		this.layer = layer;
        super(scene, world, this.generateTileBody());
        this.generateTileDrawing(tileImage);
    }
    
    function generateTileBody() {
		return echo.util.TileMap.generate(layer.data2D.flatten(), layer.gridCellWidth, layer.gridCellHeight, layer.gridCellsX, layer.gridCellsY, 0, 0, 1);
    }

    function generateTileDrawing(tileImage: h2d.Tile) {
		this.tileGroup = new h2d.TileGroup(tileImage, scene);
		this.tiles = [
			for (y in 0...Std.int(tileImage.height / layer.gridCellHeight))
				for (x in 0...Std.int(tileImage.width / layer.gridCellWidth))
					tileImage.sub(x * layer.gridCellWidth, y * layer.gridCellHeight, layer.gridCellWidth, layer.gridCellHeight)
		];
		for (y => row in this.layer.data2D) {
			for (x => tile in row) {
				if (tile != -1) {
					this.tileGroup.add(x * layer.gridCellWidth, y * layer.gridCellHeight, tiles[tile]);
				}
			}
		}
    }
}