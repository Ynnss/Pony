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
package pony.net.http.modules.mlink;

import pony.text.tpl.ITplPut;
import pony.text.tpl.TplData;
import pony.text.tpl.TplPut;

/**
 * MLinkPut
 * @author AxGord <axgord@gmail.com>
 */
@:build(com.dongxiguo.continuation.Continuation.cpsByMeta(":async"))
@:final class MLinkPut extends TplPut<MLinkConnect, {}> {
	
	@:async
	override public function shortTag(name:String, arg:String, ?kid:ITplPut):String {
		if (name == 'link') {
			return '/'+(arg == null ? '' : arg);
		} else {
			return @await super.shortTag(name, arg, kid);
		}
	}
	
	@:async
	override public function tag(name:String, content:TplData, arg:String, args:Map<String, String>, ?kid:ITplPut):String {
		
		if (name == 'link') {
			arg = arg == null ? '' : arg;
			if (args.exists('a')) {
				var c = @await parent.tplData(content);
				return '<a href="/$arg"' + (a.cpq.page == arg || a.cpq.page == arg + '/'?' class="active"':'') + '>' + c + '</a>';
			} else {
				return @await sub(this, arg, MLinkPutSub, content);
			}
		} else {
			return @await super.tag(name, content, arg, args, kid);
		}
	}
	
}