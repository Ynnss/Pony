/**
* Copyright (c) 2012-2018 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
* 
* 1. Redistributions of source code must retain the above copyright notice, this list of
*   conditions and the following disclaimer.
* 
* 2. Redistributions in binary form must reproduce the above copyright notice, this list
*   of conditions and the following disclaimer in the documentation and/or other materials
*   provided with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY ALEXANDER GORDEYKO ``AS IS'' AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ALEXANDER GORDEYKO OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/
package pony.unity3d;

import pony.ui.gui.ButtonCore;
//import pony.unity3d.ui.TintButton;
//import pony.unity3d.ui.Button;
import unityengine.GameObject;
import unityengine.Component;

using hugs.HUGSWrapper;
/**
 * StaticAccess
 * Help organize static visual objects from some ide
 * @author AxGord <axgord@gmail.com>
 */
@:nativeGen class StaticAccess {

	inline static public function component<T:Component>(gameObject:String, cl:Class<T>):T {
		#if debug
		var g:GameObject = GameObject.Find(gameObject);
		if (g == null) {
			trace('Can\'t find $gameObject game object');
			throw null;
		}
		var c = g.getTypedComponent(cl);
		if (c == null) {
			trace('Can\'t find component ' + Type.getClassName(cl) + ' in $gameObject game object');
			throw null;
		}
		return c;
		#else
		return GameObject.Find(gameObject).getTypedComponent(cl);
		#end
	}
	
	//inline static public function tintButton(gameObject:String):ButtonCore return component(gameObject, TintButton).core;
	//inline static public function button(gameObject:String):ButtonCore return component(gameObject, Button).core;
	
}