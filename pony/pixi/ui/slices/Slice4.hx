/**
* Copyright (c) 2012-2016 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
*
*   1. Redistributions of source code must retain the above copyright notice, this list of
*      conditions and the following disclaimer.
*
*   2. Redistributions in binary form must reproduce the above copyright notice, this list
*      of conditions and the following disclaimer in the documentation and/or other materials
*      provided with the distribution.
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
*
* The views and conclusions contained in the software and documentation are those of the
* authors and should not be interpreted as representing official policies, either expressed
* or implied, of Alexander Gordeyko <axgord@gmail.com>.
**/
package pony.pixi.ui.slices;

/**
 * Slice4
 * @author AxGord <axgord@gmail.com>
 */
class Slice4 extends Slice9 {
	
	public function new(data:Array<String>, useSpriteSheet:Bool = false) {
		data = [
			data[0], data[1], data[0],
			data[2], data[3], data[2],
			data[0], data[1], data[0]
		];
		super(data, useSpriteSheet);
	}
	
	override function updateWidth():Void {
		if (!inited) return;
		super.updateWidth();
		images[2].x += images[2].width;
		images[2].width = -images[2].width;
		images[5].x += images[5].width;
		images[5].width = -images[5].width;
		images[8].x += images[8].width;
		images[8].width = -images[8].width;
	}
	
	override function updateHeight():Void {
		if (!inited) return;
		super.updateHeight();
		for (i in 6...9) {
			images[i].y += images[i].height;
			images[i].height = -images[i].height;
		}
	}
	
}