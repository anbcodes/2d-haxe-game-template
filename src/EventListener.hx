class EventListener {
	public var pressedKeys: Map<Int, Bool> = [];

    public function new() {
		hxd.Window.getInstance().addEventTarget(this.onEvent);
    }

    function onEvent(event: hxd.Event) {
		switch (event.kind) {
			case EKeyDown:
				this.pressedKeys[event.keyCode] = true;
			case EKeyUp:
				this.pressedKeys[event.keyCode] = false;
			case _:
		}
    }
}