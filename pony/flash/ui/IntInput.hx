package pony.flash.ui;
import flash.events.Event;
import pony.events.Signal;

/**
 * IntInput
 * @author AxGord <axgord@gmail.com>
 */
class IntInput extends InputBase<Null<Int>> {

	public var min:Int = 0;
	public var max:Int = 100;
	
	public function new() {
		super();
		inp.removeEventListener(Event.CHANGE, chHandler);
		inp.addEventListener(Event.CHANGE, changeHandler);
		inp.restrict = '0-9';
	}
	
	private function changeHandler(_):Void {
		var v:Int = value;
		if (v < min) value = min;
		else if (v > max) value = max;
		change.dispatch(value);
	}
	
	override private function get_value():Null<Int> {
		if (inp.text == '') return null;
		return Std.parseInt(inp.text);
	}
	
	override private function set_value(v:Null<Int>):Null<Int> {
		inp.text = v == null ? '' : Std.string(v);
		return v;
	}
	
}