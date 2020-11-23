import h2d.Graphics;
import hxd.Key;

class Player extends Entity {
    var speedUpRate:Float = 140;
    var jumpSpeedUp:Float = 1200;
    var color: Int = 0x555555;
    var width: Int = 8;
    var height: Int = 16;
	var graphics:h2d.Graphics;
    var eventListener:EventListener;

    public function new(scene: h2d.Scene, world: echo.World) {
		super(scene, world, [new echo.Body({
			mass: 5,
			x: 10,
			y: 10,
			drag_x: 3000,
			drag_y: 200,
            elasticity: 0,
            max_velocity_x: this.speedUpRate * 3,
            max_velocity_y: this.jumpSpeedUp * 1.5
        })]);

        this.graphics = new h2d.Graphics(scene);

        this.body.shape = echo.Shape.rect(this.width / 2, this.height / 2, this.width, this.height);

        this.eventListener = new EventListener();
    }

    public function draw() {
		if (this.eventListener.pressedKeys[Key.SPACE] && this.body.velocity.y == 0) {
			this.body.velocity.y = -(this.jumpSpeedUp);
		}
		if (this.eventListener.pressedKeys[Key.D]) {
			this.body.velocity.x += this.speedUpRate;
		}
		if (this.eventListener.pressedKeys[Key.A]) {
			this.body.velocity.x -= this.speedUpRate;
        }

		this.graphics.clear();

		this.graphics.beginFill(this.color);

		this.graphics.drawRect(Math.round(this.body.x), Math.round(this.body.y), this.width, this.height);

		this.graphics.endFill();
    }
}