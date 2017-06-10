package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * VolumeState handles the "Go for volume!" minigame
 * @author Ramsey Opp
 */
class VolumeState extends FlxState
{
	private var startTime:Float;
	private var playTime:Float;
	
	private var currentText:FlxText;
	
	private var ready:Bool;
	private var inGoState:Bool;
	private var inWinState:Bool;
	
	//1: z, 2: /
	private var winner:Int;
	
	private var zSprite:FlxSprite;
	private var slashSprite:FlxSprite;
	private var zPoopSprite:FlxSprite;
	private var slashPoopSprite:FlxSprite;
	
	private var zCount:Int;
	private var slashCount:Int;
	
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
		inGoState = false;
		inWinState = false;
		winner = 0;
		zCount = 0;
		slashCount = 0;
		
		//generate a random time between 1 and 10 seconds
		startTime = 3;
		playTime = 5;
		
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
		slashSprite = new FlxSprite();
		
		zSprite.loadGraphic(AssetPaths.zchar__png, false, 16, 16);
		slashSprite.loadGraphic(AssetPaths.slashchar__png, false, 16, 16);
		
		zSprite.setPosition(200, 300);
		slashSprite.setPosition(500, 300);
		
		add(zSprite);
		add(slashSprite);
		
		currentText = new FlxText(200, 200, 300, "Out-shit your opponent, this time by volume! P1: press z, P2: press /. Slam that shit as fast as your body will let you, winner takes all. Press Space when ready!", 12);
		
		add(currentText);
	}
	
	/**
	 * Adds a poop sprite in a random location.
	 * 
	 * @param	startX - the center X of the poopable location
	 * @param	startY - the center Y of the poopable location
	 * @param	radius - the radius of the poopable location
	 * 
	 * Returns:
	 * 	None
	 */
	private function addRandomShit(startX, startY, radius):Void {
		var randomPoop:FlxSprite = new FlxSprite();
		randomPoop.loadGraphic(AssetPaths.itsbrown__png, false, 16, 16);
		
		//get 2 values between -radius and +radius
		var randomX:Float = radius * 2 * Math.random() - radius;
		var randomY:Float = radius * 2 * Math.random() - radius;
		
		randomPoop.setPosition(startX + randomX, startY + randomY);
		add(randomPoop);
	}

	/**
	 * Handles updates on tick
	 * 
	 * @param	elapsed - time passed between ticks
	 */
	override public function update(elapsed:Float):Void {
		handleInput();
		
		if(!inGoState && !inWinState) {
			if (startTime <= 0){
				currentText.text = "Shit!";
				currentText.size = 20;
				inGoState = true;
			}
			else if (ready) {
				startTime -= elapsed;
				currentText.text = Math.ceil(startTime) + "...";
			}
		}
		else{
			playTime -= elapsed;
			if (playTime <= 0) {
				inGoState = false;
				inWinState = true;
				if (zCount > slashCount) {
					currentText.text = "Congrats Z, you take home the gold!";
				}
				else if (slashCount > zCount) {
					currentText.text = "Congrats /, you take home the gold!";
				}
				else{
					currentText.text = "Tie? Well I guess you can... split the trophy.";
				}
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
			currentText.size = 14;
			ready = true;
		}
		
		if (inGoState) {
			var zPressed:Bool = FlxG.keys.justPressed.Z;
			var slashPressed:Bool = FlxG.keys.justPressed.SLASH;
			if (zPressed){
				zCount++;
				
				addRandomShit(192 - zCount * 2, 308 + zCount * 2, zCount * 2);
				
			}
			if (slashPressed){
				slashCount++;
				
				addRandomShit(508 + slashCount * 2, 308 + slashCount * 2, zCount * 2);
			}
		}
	}
	
}