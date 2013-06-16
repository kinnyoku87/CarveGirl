package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.media.SfxManager;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class UserB_UIState extends UIState
	{
		public function UserB_UIState()
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
			var l:int, i:int, count:int, value:int
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('user_panel_B')
			doc.addChild(mc)
			
			mc.title.gotoAndStop(4 - stateArgs[3])
			mc.userAge.gotoAndStop(4 - stateArgs[3])
			mc.userLevel.gotoAndStop(1 + stateArgs[2])

			if(mMoney <= PlayerManager.getInstance().player.money.value)
			{
				mc.bgC.gotoAndStop(1)	
			}
			else
			{
				mc.bgC.gotoAndStop(2)
			}
				
			mc.txtC.text = mMoney / 10000 + 'W'
			
			l = mData.length
			for(i=0;i<l;i++)
			{
				value = mData[i]
				if(value > 0)
				{
					if(count == 0)
					{
						mc.txtA.text = '+' + value
						mc.itemA.gotoAndStop(i+1)
						if(value <= PlayerManager.getInstance().player.itemList[i].value)
						{
							mc.bgA.gotoAndStop(1)	
						}
						else
						{
							mc.bgA.gotoAndStop(2)
						}
					}
					else if(count == 1)
					{
						mc.txtB.text = '+' + value
						mc.itemB.gotoAndStop(i+1)
						if(value <= PlayerManager.getInstance().player.itemList[i].value)
						{
							mc.bgB.gotoAndStop(1)	
						}
						else
						{
							mc.bgB.gotoAndStop(2)
						}
						break
					}
					++count
				}
			}
			
			if(mMoney <= PlayerManager.getInstance().player.itemList[i].value)
			{
				mc.bgC.gotoAndStop(1)	
			}
			else
			{
				mc.bgC.gotoAndStop(2)
			}
			
			this.fusion.addElement(doc)
			
			btn = new Button('user_close_btn')
			this.fusion.addElement(btn, 651.35, 2.5)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserB').close()
				PlayerManager.getInstance().nextRound()
			})
			
			btn = new Button('user_interview_btn')
			this.fusion.addElement(btn, 220, 311.3)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('UserB').close()
				DespairUI.getPanel('UserD').popup(-1,true,stateArgs)
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
