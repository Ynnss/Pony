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
package pony.flash.ui;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.events.Event;
import pony.geom.Rect;
import pony.ui.gui.GridCore;

using pony.flash.FLExtends;

/**
 * Grid
 * @author AxGord
 */
class Grid extends Sprite {
	
	private var slots:Array<Array<GridSlot>>;
	
	public var core:GridCore;
	
	public function new() {
		super();
		slots = [];
	}
	
	public function init(core:GridCore):Void {
		this.core = core;
		core.setTotal(width, height);
		
		for (_ in 0...numChildren) removeChildAt(0);
		for (iy in 0...core.cy) {
			var a:Array<GridSlot> = [];
			for (ix in 0...core.cx) {
				var g:GridSlot = new GridSlot();
				addChild(g);
				g.x = ix * core.slotWidth;
				g.y = iy * core.slotHeight;
				a.push(g);
			}
			slots.push(a);
		}
		core.makeMark = makeMark;
	}
	
	private function makeMark(x:Int, y:Int, state:Bool):Void slots[x][y].mark = state;
		
}