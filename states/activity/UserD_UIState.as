package states.activity
{
	import flash.display.MovieClip;
	
	import models.PlayerManager;
	
	import org.despair2D.ui.Button;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class UserD_UIState extends UIState
	{
		public function UserD_UIState()
		{
			super();
		}
		
		override public function enter(stateArgs:Array):void
		{
			mData = stateArgs[0]
			mMoney = stateArgs[1]
			
			var doc:DisplayObjectContainerPuppet
			var btn:Button
			var mc:MovieClip
			var l:int, i:int, count:int
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('user_panel_D')
			doc.addChild(mc)
			
			mc.title.gotoAndStop(4 - stateArgs[3])
			mc.userAge.gotoAndStop(4 - stateArgs[3])
			mc.userLevel.gotoAndStop(1 + stateArgs[2])
			this.fusion.addElement(doc)
			mc.bgA.gotoAndStop(1)	
			mc.bgB.gotoAndStop(1)	
				
			btn = new Button('user_close_btn')
			this.fusion.addElement(btn, 651.35, 2.5)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserD').close()
				PlayerManager.getInstance().nextRound()
			})
			
			btn = new Button('user_ok_btn')
			this.fusion.addElement(btn, 479, 311.05)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserD').close()
				PlayerManager.getInstance().nextRound()
			})
			
			var index:int
			var R:int
			
			index = ArrayUtil.pullRandom(list)
			mc.itemA.gotoAndStop(index)
			R = int(MathUtil.getRandomBetween(1,3.999));
			mc.txtA.text = '+' + R
			PlayerManager.getInstance().getPropertyByIndex(index).value += R
			
			index = ArrayUtil.pullRandom(list)
			mc.itemB.gotoAndStop(index)
			R = int(MathUtil.getRandomBetween(1,3.999));
			mc.txtB.text = '+' + R
			PlayerManager.getInstance().getPropertyByIndex(index).value += R
				
			this.fusion.x = (DespairUI.screenWidth - mc.width) / 2
			this.fusion.y = (DespairUI.screenHeight - mc.height) / 2
		}
		
		override public function exit():void
		{
			mData = null
			list = null
		}
		
		
		private var list:Array = [1,2,3,4]
		
		private var mData:Array
		
		private var mMoney:int
	}
}
