package states.activity
{
	import flash.display.MovieClip;
	
	import carveGirlAssets.SoundAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.media.SfxManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class UserF_UIState extends UIState
	{
		public function UserF_UIState()
		{
			super();
		}
		
		override public function enter():void
		{
			mData = stateArgs[0]
			mMoney = stateArgs[1]
			
			var doc:DisplayObjectContainerPuppet
			var btn:Button
			var mc:MovieClip
			var l:int, i:int, count:int
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('user_panel_F')
			doc.addChild(mc)
			
			mc.title.gotoAndStop(4 - stateArgs[3])
			mc.userAge.gotoAndStop(4 - stateArgs[3])
			mc.userLevel.gotoAndStop(1 + stateArgs[2])
			this.fusion.addElement(doc)
			
			btn = new Button('user_close_btn')
			this.fusion.addElement(btn, 651.35, 2.5)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserF').close()
				PlayerManager.getInstance().nextRound()
			})
			
			btn = new Button('user_ok_btn')
			this.fusion.addElement(btn, 479, 311.05)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserF').close()
				PlayerManager.getInstance().nextRound()
			})
			
			this.fusion.x = (DespairUI.screenWidth - mc.width) / 2
			this.fusion.y = (DespairUI.screenHeight - mc.height) / 2
		}
		
		override public function exit():void
		{
			mData = null
		}
		
		private var mData:Array
		
		private var mMoney:int
	}
}