class Entity {
    var scene: h2d.Scene;
    var world: echo.World;
    public var bodies: Array<echo.Body>;
	public var body: echo.Body;

	public function new(scene:h2d.Scene, world: echo.World, bodies: Array<echo.Body>, mainBody = 0) {
		this.scene = scene;
        this.world = world;
        this.bodies = bodies;
		this.body = bodies[mainBody];

        for (b in bodies) this.world.add(b);
    }

    public function collideWith(entity: Entity) {
        this.world.listen(this.bodies, entity.bodies);
    }
}