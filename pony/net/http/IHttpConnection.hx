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
package pony.net.http;

import pony.fs.File;
/**
 * IHttpConnection
 * @author AxGord
 */

interface IHttpConnection
{
	var method:String;
	var post:Map<String, String>;
	var fullUrl:String;
	var url:String;
	var params:Map<String, String>;
	var sessionStorage:Map<String, Dynamic>;
	var host:String;
	var protocol:String;
	var languages:Array<String>;
	var cookie:Cookie;
	var end:Bool;
	
	function sendFile(file:File):Void;
	function sendFileOrIndexHtml(path:String):Void;
	function endAction():Void;
	function goto(url:String):Void;
	function endActionPrevPage():Void;
	function error(?message:String):Void;
	function notfound(?message:String):Void;
	function sendHtml(text:String):Void;
	function sendText(text:String):Void;
	function mix():Map<String, String>;
}