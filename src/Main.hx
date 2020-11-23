class Main extends hxd.App {
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
			gravity_y: 900,
			iterations: 5,
			history: 1000
        });
        
        this.player = new Player(this.s2d, this.world);

        this.tiles = new Tiles(this.s2d, this.world, level.layers[0], hxd.Res.tiles.toTile());

        this.player.collideWith(this.tiles);

        this.setScale();
    }
    
    function setScale() {
		var shouldFitX = 16 * 2;

		var tileWidth = this.s2d.width / shouldFitX;

		this.scale = tileWidth / this.level.layers[0].gridCellWidth;

		this.s2d.scaleMode = Zoom(this.scale);
    }

	override function update(dt:Float) {
		this.world.step(dt);

        this.followPlayer();

        this.player.draw();
    }
    
	function followPlayer() {
		this.s2d.x = Math.round(-this.player.body.x + this.engine.width / (2 * this.scale));
		this.s2d.y = Math.round(-this.player.body.y + this.engine.height / (2 * this.scale));
    }

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}