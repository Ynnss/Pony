/**
* Copyright (c) 2012 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
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
package pony.tpl;

import pony.magic.async.AsyncAuto;
import pony.magic.Declarator;
import pony.tpl.Parse;

typedef TplData = Array<TplContent>;

enum TplContent {
	Text(t:String);
	Tag(t:TplTag);
	ShortTag(t:TplShortTag);
}

typedef TplTag = {
	name: TplTagName,
	args: Hash<TplData>,
	arg: TplData,
	content: TplData
};

typedef TplShortTag = {
	name: TplTagName,
	arg: TplData
};

typedef TplTagName = {
	up:Int,
	name:Array<String>
};

typedef TplStyle = {
	begin:String,
	end:String,
	endClose:String,
	closeBegin:String,
	closeEnd:String,
	shortBegin:String,
	shortEnd:String,
	args:TplStyleArgs,
	group:String,
	up:String,
	space:Bool
};

typedef TplStyleArgs = {
	begin: String,
	end: String,
	delemiter: String,
	set: String,
	valueq: String,
	qalltime: Bool,
	nonamearg: Bool
};


/**
 * ...
 * @author AxGord
 */

class Tpl implements AsyncAuto
{
	public static var styles:Dynamic<TplStyle> = {
		def: {
			begin: '<_',
			end: '>',
			endClose: '/>',
			closeBegin: '</_',
			closeEnd: '>',
			shortBegin: '%',
			shortEnd: '%',
			args: {
				begin: ' ',
				end: '',
				delemiter: ' ',
				set: '=',
				valueq: '"',
				qalltime: false,
				nonamearg: true
			},
			group: '-',
			up: '-',
			space: true
		},
		square: {
			begin: '[',
			end: ']',
			endClose: '/]',
			closeBegin: '[/',
			closeEnd: ']',
			shortBegin: '$',
			shortEnd: '',
			args: {
				begin: '{',
				end: '}',
				delemiter: ',',
				set: ':',
				valueq: '"',
				qalltime: false,
				nonamearg: true
			},
			group: '>',
			up: '^',
			space: true
		}
	};
	
	private var data:TplData;
	private var c:Class<Dynamic>;
	private var o:Dynamic;
	
	public function new(?c:Class<Dynamic>, o:Dynamic, t:String, ?s:TplStyle)
	{
		this.c = c;
		this.o = o;
		if (s == null) s = styles.def;
		data = Parse.parse(t, s);
	}
	
	@AsyncAuto
	public function gen(?d:Dynamic, ?p:ITplPut):String {
		return go(o, d, p, c, data);
	}
	
	@AsyncAuto
	public static function go(o:Dynamic, d:Dynamic, p:ITplPut, ?c:Class<Dynamic>, content:TplData):String {
		if (c == null) {
			c = o.tplPut;
			if (c == null)
				throw 'Need tplPut';
		}
		var r:ITplPut = Type.createInstance(c, [o,d,p]);
		return r.tplData(content);
	}
	
}