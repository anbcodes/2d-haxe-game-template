class Main extends hxd.App {
    var shouldFitX: Int = 16 * 2;
    var scale: Float;
    var world: echo.World;
    var player: Player;
    var tiles: Tiles;
	var level: Dynamic;

	override function init() {
        this.level = haxe.Json.parse(hxd.Res.level.entry.getText());
		this.world = echo.Echo.start({
			width: level.layers[0].gridCellWidth * level.layers[0].gridCellsX,
			height: level.layers[0].gridCellHeight * level.layers[0].gridCellsY,
			gravity_y: 2500,
			iterations: 5,
			history: 1000
        });
        
        this.player = new Player(this.s2d, this.world);

        this.tiles = new Tiles(this.s2d, this.world, level.layers[0], hxd.Res.tiles.toTile());

        this.player.collideWith(this.tiles);

        this.setScale();
    }
    
    function setScale() {
		var tileWidth = this.s2d.width / this.shouldFitX;

		this.scale = tileWidth / this.level.layers[0].gridCellWidth;

		this.s2d.scaleMode = Zoom(this.scale);
    }

	override function update(dt:Float) {
		this.world.step(dt);

        this.followPlayer();

        this.player.draw();
    }
    
	function followPlayer() {
        var cellW = this.level.layers[0].gridCellWidth;
        var cellH = this.level.layers[0].gridCellHeight;
        var cellsX = this.level.layers[0].gridCellsX;
        var cellsY = this.level.layers[0].gridCellsY;
        var halfScreenX = (this.shouldFitX / 2);
        var halfScreenY = ((this.shouldFitX / 16) * 8) / 2;
        

		var levelPixelsWidth = cellW * (cellsX - halfScreenX);
        var levelPixelsHeight = cellH * (cellsY - halfScreenY);
        this.s2d.x = Math.round(-Math.max(Math.min(this.player.body.x, levelPixelsWidth), halfScreenX * cellW) + this.engine.width / (2 * this.scale));
        
		this.s2d.y = Math.round(-Math.max(Math.min(this.player.body.y, levelPixelsHeight), halfScreenY * cellH) + this.engine.height / (2 * this.scale));
    }

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}