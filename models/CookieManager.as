package models
{
	import org.despair2D.control.CookieUtil;
	import org.despair2D.control.ICookie;

	public class CookieManager
	{

		
		public static function get cookie() :ICookie
		{
			if(!mCookie)
			{
				mCookie = CookieUtil.createCookie('CarveGirl')
			}
			
			return mCookie
		}
		
		public static function flush():void
		{
			var cookie:ICookie = CookieUtil.getCookie('CarveGirl')
			cookie.userData = PlayerManager.getInstance().player.getData()
			cookie.flush()
		}
		
		private static var mCookie:ICookie
		
	}
}