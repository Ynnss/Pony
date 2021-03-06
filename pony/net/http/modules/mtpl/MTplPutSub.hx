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
package pony.net.http.modules.mtpl;

import pony.text.tpl.ITplPut;
import pony.text.tpl.TplData;
import pony.text.tpl.TplPut;
import pony.text.tpl.TplSystem;
import pony.text.tpl.Valuator;

/**
 * MTplPutSub
 * @author AxGord <axgord@gmail.com>
 */
@:build(com.dongxiguo.continuation.Continuation.cpsByMeta(":async"))
@:final class MTplPutSub extends Valuator<MTplPut, TplSystem> {
	
	@:async
	override public function tag(name:String, content:TplData, arg:String, args:Map<String, String>, ?kid:ITplPut):String
	{
		if (name == 'selected') return @await super.tag(name, content, arg, args, kid);
		else {
			var r = @await valu(name, arg);
			if (r != null) {
				if (content != null) {
					return @await super.tag(name, content, arg, args, kid);
				} else 
					return r;
			} else {
				return @await parentTag(name, content, arg, args, kid);
			}
		}
	}
	
	@:async
	override public function valuBool(name:String):Bool {
		if (name == 'selected') {
			var c:CPQ = a.b;
			return c.template == b;
		} else
			return null;
	}
	
	@:async
	override public function valu(name:String, arg:String):String {
		var m:Manifest = b.manifest;
		return switch (name) {
			case 'name': b.name;
			case 'title': sie(m, 'title', b.name);
			case 'author': sie(m, 'author');
			case 'email': sie(m, 'email');
			case 'www': sie(m, 'www');
			case 'license': sie(m, 'license');
			case 'version': m != null && m.version != null ? m.version.major + '.' + m.version.minor : '';
			case 'extends':
				if (m != null && m._extends != null)
					@await TplPut.manyEasy(m._extends, null, arg == null ? ', ' : arg);
				else
					'';
			default:
				null;
		}
	}
	
	private static inline function sie(m:Manifest, f:String, r:String=''):String {
		return m != null && Reflect.field(m, f) != null ? Reflect.field(m, f) : r;
	}
	
}