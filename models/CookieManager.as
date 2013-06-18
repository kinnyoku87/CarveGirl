package models
{
	import org.despair2D.control.CookieUtil;
	import org.despair2D.control.ICookie;

	public class CookieManager
	{

		
		public static function get cookie() :ICookie
		{
			return mCookie ||= CookieUtil.createCookie('CarveGirl')
		}
		
		public static function flush():void
		{
			mCookie.userData = PlayerManager.getInstance().player.getData()
			mCookie.flush()
		}
		
		
		private static var mCookie:ICookie
		
	}
}