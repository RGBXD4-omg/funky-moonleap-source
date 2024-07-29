package meta.state.menus.menuObjects;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import meta.data.PlayerSettings;
#if android
import flixel.input.actions.FlxActionInput;
import android.FlxVirtualPad;
#end
/*
*	just a FlxTypedGroup with step/beat hit functions and controls
*/
class MusicBeatGroup extends FlxTypedGroup<FlxBasic>
{
	public var groupName:String = 'none';
	
	private var controls(get, never):Controls;
	
	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
	#if android
	var _virtualpad:FlxVirtualPad;
	var trackedinputsUI:Array<FlxActionInput> = [];
	var trackedinputsNOTES:Array<FlxActionInput> = [];
	#end
	
	#if android
	public function addVirtualPad(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
		_virtualpad = new FlxVirtualPad(DPad, Action, 0.75);
		add(_virtualpad);
		controls.setVirtualPadUI(_virtualpad, DPad, Action);
		trackedinputsUI = controls.trackedinputsUI;
		controls.trackedinputsUI = [];
	}
	#end

	#if android
	public function removeVirtualPad() {
		controls.removeFlxInput(trackedinputsUI);
		remove(_virtualpad);
	}
	#end

	#if android
		public function addPadCamera() {
		var camcontrol = new flixel.FlxCamera();
		camcontrol.bgColor.alpha = 0;
		FlxG.cameras.add(camcontrol, false);
		_virtualpad.cameras = [camcontrol];
	}
	#end
	
	override function destroy() {
		#if android
		controls.removeFlxInput(trackedinputsUI);
		controls.removeFlxInput(trackedinputsNOTES);
		#end

		super.destroy();
	}
	
	public function new()
		super();
	
	// funny beat stuff if you want to use it i guess
	public function stepHit(curStep:Int = 0) {}
	public function beatHit(curBeat:Int = 0) {}
}
