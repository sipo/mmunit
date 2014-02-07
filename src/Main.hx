package ;


/**
 * 実行ファイル
 * 
 * @author sipo
 */

import jp.sipo.mmunit.MAssert;
class Main 
{
	
	static function main() 
	{
		MAssert.areEqual("A", "A");
		MAssert.areEqual("A", "B");
	}
	
}
