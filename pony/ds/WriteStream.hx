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
package pony.ds;

import pony.events.Signal0;

class WriteStream<T> implements pony.magic.HasLink {

	public var readStream:ReadStream<T>;

	public var onGetData(link, never):Signal0 = base.onGetData;
	public var onCancel(link, never):Signal0 = base.onCancel;
	public var onComplete(link, never):Signal0 = base.onComplete;

	public var data(link, never):T -> Void = base.data;
	public var end(link, never):T -> Void = base.end;
	public var error(link, never):Void -> Void = base.error;

	public var base(default, null):BaseStream<T> = new BaseStream<T>();

	public function new() {
		readStream = new ReadStream<T>(base);
	}

	public inline function start():Void readStream.next();

	public function pipe(rs:ReadStream<T>):Void {
		rs.onData << data;
		rs.onEnd << end;
		rs.onError << error;
		onGetData << rs.next;
		onCancel << rs.cancel;
		onComplete << rs.complete;
		start();
	}

}