package models
{
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.events.PanelEvent;
	
	import states.SceneUIState;

	public class PlayerManager
	{
		
		public function PlayerManager()
		{
			//DespairUI.getPanel('Dice').popup(-1,true,false)
			DespairUI.getPanel('Scene').addEventListener(SceneUIState.STOP, __onScenePlayerStop)
		}
		
		
		// 0:起点
		// 1:儿童用户
		// 2:青年用户
		// 3:中年用户
		// 4:老年用户
		// 5:咖啡厅
		// 6:事件
		// 7:公园
		public static const pathUserData:Array = [0, 1, 3, 5, 6, 2, 7, 4, 3, 6,
			1, 3, 6, 2, 4, 5, 1, 3, 6, 2,
			4, 6, 1, 3, 7, 4, 2, 1, 6, 2,
			3, 5, 4, 1, 7, 6, 2, 4]
		
		public static const pathUserDataB:Array = ['起点','儿童用户','青年用户','中年用户','老年用户','咖啡厅','事件','公园']
			
		
		private static var mInstance:PlayerManager
		public static function getInstance() : PlayerManager
		{
			return mInstance ||= new PlayerManager
		}
		
		
		public function get player() : PlayerModel
		{
			return mPlayer ||= new PlayerModel
		}
		

	
		private var mPlayer:PlayerModel
		
		
		
		///////////////////////////////////////////////////////////////
		
		private function __onScenePlayerStop(e:PanelEvent):void
		{
			trace(this.player.getUserDataPrompt())
			DespairUI.getPanel('Park').popup(-1,true,false)
		}
		
		
		
		
	}
}