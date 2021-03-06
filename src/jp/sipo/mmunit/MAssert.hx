package jp.sipo.mmunit;
/**
 * 今のところマクロ専用。
 * エラーをキャッチし、呼び出し元関数の位置としてコンソール警告を出す
 * 
 * @auther sipo
 */
import haxe.PosInfos;
import haxe.macro.Context;
import sys.io.File;
import haxe.io.Bytes;
import massive.munit.Assert;
class MAssert
{
	/**
	 * Assert.areEqualを実行
	 */
	public static function areEqual(expected:Dynamic, actual:Dynamic, ?pos:PosInfos)
	{
		try{
			Assert.areEqual(expected, actual);
		}catch (error:Dynamic){
			Context.warning(Std.string(error), posInfosToPosition(pos) );
		}
	}
	
	/**
	 * PosInforをマクロ用に変換
	 * nanoTestを参考に、ほぼ真似
	 * @param	pos
	 */
	static function posInfosToPosition(pos:PosInfos) 
	{
		var file = File.read(pos.fileName).readAll().toString();
		var ereg = ~/(\r\n|\r|\n)/;
		
		var min = 0;
		for (i in 0...pos.lineNumber - 1) 
		{
			ereg.match( file );
			var pos = ereg.matchedPos();
			min += pos.pos + pos.len;
			file = ereg.matchedRight();
		}
		
		var max = min + 
			if(ereg.match( file ))
				ereg.matchedPos().pos;
			else 
				file.length;
				
		return Context.makePosition
		({
			file : pos.fileName, min : min, max : max,
		});
	}
}
