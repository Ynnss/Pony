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
package pony.events;

import pony.Priority;

/**
 * Event0
 * @author AxGord <axgord@gmail.com>
 */
@:forward(
	empty,
	onTake,
	onLost
)
abstract Event0(Priority<Listener0>) from Priority<Listener0> to Priority<Listener0> {

	@:extern inline public function new(double:Bool = false) {
		this = new Priority(double);
		this.compare = compare;
	}
	
	private static function compare<T1>(a:Listener0, b:Listener0):Bool {
		return switch [a.listener, b.listener] {
			case [LFunction0(a), LFunction0(b)]:
				SignalTools.functionHashCompare(a, b);
			case [LEvent0(a,_), LEvent0(b,_)]:
				a == b;
			case [LBind1(_,a), LBind1(_,b)]:
				a == b;
			case [LBind2(_,a1,a2), LBind2(_,b1,b2)]:
				a1 == b1 && a2 == b2;
			case _: false;
		}
	}
	
	public function dispatch(safe:Bool=false):Bool {
		if (this == null || this.isDestroy() || (safe && this.counters.length > 1)) return false;
		this.lock = true;
		for (e in this) {
			if (this.isDestroy()) return false;
			if (e.once) this.remove(e);
			if (e.call(safe)) {
				this.brk();
				return true;
			}
		}
		this.lock = false;
		return false;
	}
	
	@:op(A && B) @:extern inline public function and(s:Event0):Event0 {
		return (new Event0():Signal0).add(this).add(s);
	}
	
	@:op(A & B) @:extern inline public function andOnce(s:Event0):Event0 {
		return (new Event0():Signal0).add(this).add(s);
	}
	
	inline public function destroy():Void {
		if (this != null) this.destroy();
	}
	
}