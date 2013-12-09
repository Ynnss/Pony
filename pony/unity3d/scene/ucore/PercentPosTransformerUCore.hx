package pony.unity3d.scene.ucore;

import cs.NativeArray.NativeArray;
import pony.unity3d.scene.ucore.PercentPosUCore;
import unityengine.GameObject;
import unityengine.Time;

/**
 * PercentPosTransformer
 * @author AxGord <axgord@gmail.com>
 */
class PercentPosTransformerUCore extends PercentPosUCore {

	public var defaultView:GameObject;
	public var transformedView:GameObject;
	
	public var points:NativeArray<Single>;
	
	override public function set_percent(v:Float):Float {
		v = super.set_percent(v);
		var i = points.Length;
		while (i-- > 0) if (nullPos + size * v > points[i]) {
			defaultView.active = i % 2 != 0;
			transformedView.active = !defaultView.active;
			break;
		}
		
		return v;
	}
	
	
}