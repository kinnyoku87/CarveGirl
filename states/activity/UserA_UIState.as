package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.debug.Logger;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class UserA_UIState extends UIState
	{
		public function UserA_UIState()
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
			mc = getInstance('user_panel_A')
			doc.addChild(mc)
				
			mc.title.gotoAndStop(4 - stateArgs[3])
			mc.userAge.gotoAndStop(4 - stateArgs[3])
			mc.userLevel.gotoAndStop(1 + stateArgs[2])
			mc.bgA.gotoAndStop(1)	
			mc.bgB.gotoAndStop(1)	
			mc.bgC.gotoAndStop(1)	
			mc.txtC.text = mMoney / 10000 + 'W'
				
			l = mData.length
			for(i=0;i<l;i++)
			{
				if(mData[i] > 0)
				{
					if(count == 0)
					{
						mc.txtA.text = '+' + mData[i]
						mc.itemA.gotoAndStop(i+1)
					}
					else if(count == 1)
					{
						mc.txtB.text = '+' + mData[i]
						mc.itemB.gotoAndStop(i+1)
						break
					}
					++count
				}
			}
			this.fusion.addElement(doc)
				
			btn = new Button('user_close_btn')
			this.fusion.addElement(btn, 651.35, 2.5)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserA').close()
				PlayerManager.getInstance().nextRound()
			})
				
			btn = new Button('user_interview_btn')
			this.fusion.addElement(btn, 220, 311.3)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserA').close()
				DespairUI.getPanel('UserD').popup(-1,true,stateArgs)
			})
				
			btn = new Button('user_popularize_btn')
			this.fusion.addElement(btn, 479, 311.05)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				startPopularize(stateArgs)
			})
				
			this.fusion.x = (DespairUI.screenWidth - mc.width) / 2
			this.fusion.y = (DespairUI.screenHeight - mc.height) / 2
		}
		
		override public function exit():void
		{
			mData = null
		}
		
		
		private function startPopularize(stateArgs:Array):void
		{
			// 减钱
			PlayerManager.getInstance().player.money.value -= mMoney
			DespairUI.getPanel('UserA').close()
			
			// 成功
			if(Math.random() < 0.9)
			{
				DespairUI.getPanel('UserE').popup(-1,true,stateArgs)
					
				// 升级
				PlayerManager.getInstance().player.levelList[stateArgs[3]]++
				Logger.reportMessage('Level Up', String(PlayerManager.getInstance().player.levelList))
			}
			
			// 失败
			else
			{
				DespairUI.getPanel('UserF').popup(-1,true,stateArgs)
			}
		}
		
		
		private var mData:Array
		
		private var mMoney:int
	}
}