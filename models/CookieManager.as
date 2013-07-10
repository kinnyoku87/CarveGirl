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
		
		public static function get hero() : ICookie
		{
			return mHero ||= CookieUtil.createCookie('Hero')
		}
		
		public static function flush():void
		{
			mCookie.userData = PlayerManager.getInstance().player.getData()
			mCookie.flush()
		}
		
		public static function flushHero():void
		{
			mHero.userData = PlayerManager.getInstance().heroList
			mHero.flush()
		}
		
		public static function clear() : void
		{
			mCookie.userData = {}
			mCookie.flush()
		}
		
		
		private static var mCookie:ICookie, mHero:ICookie
		
	}
}