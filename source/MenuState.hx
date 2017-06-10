package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * MenuState builds the menu and handles switching to minigames
 * on click.
 * @author Ramsey Opp
 */
class MenuState extends FlxState {
	private var btnQuick:FlxButton;
	private var btnVolume:FlxButton;
	
	/* Build the menu */
	override public function create():Void {
		btnQuick = new FlxButton(0, 0, "Play QuickShit", clickQuick);
		btnQuick.screenCenter();
		add(btnQuick);
		
		btnVolume = new FlxButton(0, 0, "Go for volume!", clickVolume);
		btnVolume.setPosition(btnQuick.x, btnQuick.y + 40);
		add(btnVolume);
		
		super.create();
	}
	
	/* Start a quick-draw game */
	private function clickQuick():Void {
		FlxG.switchState(new QuickState());
	}
	
	/* Start a rapid-press game */
	private function clickVolume():Void {
		FlxG.switchState(new VolumeState());
	}
}