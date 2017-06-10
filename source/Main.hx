package;

import flixel.FlxGame;
import openfl.display.Sprite;

/**
 * Main starts the menu state.
 * @author Ramsey Opp
 */
class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(640, 480, MenuState));
	}
}