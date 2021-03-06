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
package pony.sys.nodejs;

import js.node.ChildProcess;
import pony.events.Signal1;

class Process extends pony.Logable implements pony.sys.IProcess implements pony.magic.HasSignal {

	@:auto public var onComplete:Signal1<Int>;

	public var runned(default, null):Bool = false;

	private var runCmd:String;
	private var keep:Bool;
	private var waitEnd:Bool = false;
	private var process:js.node.child_process.ChildProcess;

	public function new(runCmd:String, keep:Bool = false) {
		super();
		this.runCmd = runCmd;
		this.keep = keep;
	}

	public function run():Bool {
		if (runned) {
			return false;
		} else {
			runned = true;
			runProccess();
			return true;
		}
	}

	public function kill():Bool {
		if (runned) {
			runned = false;
			process.kill();
			process.removeAllListeners();
			process = null;
			return true;
		} else {
			return false;
		}
	}

	private function runProccess():Void {
		log('Run: ' + runCmd);
		waitEnd = true;
		process = ChildProcess.exec(runCmd, execHandler);
		//var s = getPidsFile();
		//sys.io.File.saveContent(Config.file_pids, (s != '' ? '\n' : '') + process.pid);
		process.stdout.on('data', log);
		process.stderr.on('data', error);
		process.on('exit', endProcess);
	}

	private function execHandler(err:Null<ChildProcessExecError>, a1:String, a2:String):Void {
		log('$runCmd is exec\n');
		if (a2 != '') error(a2);
		endProcess(err == null ? 0 : err.code);
	}

	private function endProcess(code:Int):Void {
		if (waitEnd) {
			waitEnd = false;
			if (code != null && code > 0)
				error('Child ($runCmd) exited with code $code');
			if (keep) {
				if (runned) runProccess();
			} else {
				runned = false;
				eComplete.dispatch(code);
			}
		}
	}

	public function destroy():Void {
		kill();
		destroySignals();
		runCmd = null;
	}

	public static function stderr(v:String):Void {
		js.Node.console.error(v);
	}
	
	/*
	public static function killAll():Void {
		var pids = getPidsFile().split('\n').map(function(v:String):Int return Std.parseInt(v));
		for (pid in pids) {

		}
	}

	public static function getPidsFile():String {
		if (sys.FileSystem.exists(Config.file_pids)) {
			return sys.io.File.getContent(Config.file_pids);
		} else {
			return '';
		}
	}
	*/

}