package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * QuickState handles the quickdraw minigame
 * @author Ramsey Opp
 */
class QuickState extends FlxState
{
	private var drawTime:Float;
	private var currentText:FlxText;
	
	private var ready:Bool;
	private var inDrawState:Bool;
	private var inWinState:Bool;
	
	//1: z, 2: /
	private var winner:Int;
	
	private var zSprite:FlxSprite;
	private var slashSprite:FlxSprite;
	private var zPoopSprite:FlxSprite;
	private var slashPoopSprite:FlxSprite;
	
	/**
	 * Initializes the game state.
	 * Params:
	 * 	None
	 * 
	 * Returns:
	 * 	None
	 */
	override public function create():Void {
		ready = false;
		inDrawState = false;
		inWinState = false;
		winner = 0;
		
		//generate a random time between 1 and 10 seconds
		drawTime = 1.5;
		drawTime += 10 * Math.random();
		
		loadGraphics();
		
		super.create();
	}
	
	/**
	 * Sets up and loads the sprites and the explanation text
	 * Params:
	 * 	None
	 * 
	 * Returns:
	 * 	None
	 */
	private function loadGraphics():Void {
		zSprite = new FlxSprite();
		zPoopSprite = new FlxSprite();
		
		slashSprite = new FlxSprite();
		slashPoopSprite = new FlxSprite();
		
		zSprite.loadGraphic(AssetPaths.zchar__png, false, 16, 16);
		zPoopSprite.loadGraphic(AssetPaths.itsbrown__png, false, 16, 16);
		
		slashSprite.loadGraphic(AssetPaths.slashchar__png, false, 16, 16);
		slashPoopSprite.loadGraphic(AssetPaths.itsbrown__png, false, 16, 16);
		
		zSprite.setPosition(200, 300);
		zPoopSprite.setPosition(192, 308);
		
		slashSprite.setPosition(500, 300);
		slashPoopSprite.setPosition(508, 308);
		
		add(zSprite);
		add(zPoopSprite);
		add(slashSprite);
		add(slashPoopSprite);
		
		zPoopSprite.visible = false;
		slashPoopSprite.visible = false;
		
		currentText = new FlxText(200, 200, 300, "Out-shit your opponent! P1: press z, P2: press /. Be careful not to shit too early or your competitive career goes straight down the toilet. Press Space when ready!", 12);
		
		add(currentText);
	}

	/**
	 * Handles updates on tick
	 * 
	 * @param	elapsed - time passed between ticks
	 */
	override public function update(elapsed:Float):Void {
		handleInput();
			
		if(!inDrawState && !inWinState) {
			if (drawTime <= 0) {
				currentText.text = "Draw!";
				currentText.size = 20;
				inDrawState = true;
			}
			else if (ready) {
				drawTime -= elapsed;
			}
		}
		super.update(elapsed);
	}
	
	/**
	 * Handles input
	 * 
	 * Params:
	 * 	None
	 * 
	 * Returns:
	 * 	None
	 */
	private function handleInput():Void {
		var escapePressed = FlxG.keys.justPressed.ESCAPE;
		if (escapePressed) {
			FlxG.switchState(new MenuState());
		}
		
		var spacePressed = FlxG.keys.justPressed.SPACE;
		if (spacePressed && !inWinState) {
			currentText.text = "Ready.....";
			currentText.size = 14;
			ready = true;
		}
		
		if (ready && !inWinState) {
			var zPressed:Bool = FlxG.keys.justPressed.Z;
			var slashPressed:Bool = FlxG.keys.justPressed.SLASH;
			if(zPressed || slashPressed){
				inWinState = true;
			}
			if (zPressed && slashPressed){
				zPoopSprite.visible = true;
				slashPoopSprite.visible = true;
				if (inDrawState){
					currentText.text = "It's a... draw.";
				}
				else {
					currentText.text = "Slow down! How did you manage to lose simultaneously?";
				}
			}
			else if (zPressed){
				zPoopSprite.visible = true;
				if (inDrawState){
					currentText.text = "Good shit! Z Wins!";
				}
				else {
					currentText.text = "Whoops, too early! / Wins!";
				}
			}
			else if (slashPressed){
				slashPoopSprite.visible = true;
				if (inDrawState){
					currentText.text = "Good shit! / Wins!";
				}
				else {
					currentText.text = "Whoops, too early! Z Wins!";
				}
			}
		}
	}
}