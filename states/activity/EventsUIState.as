package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.EventModel;
	import models.EventsManager;
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
	
	public class EventsUIState extends UIState
	{
		public function EventsUIState()
		{
			super();
		}
		
		private static var mLoaded:Boolean
		
		private static const positionList:Array = [[84.5,334,140.5,316.45], 
			[284.3,334,343.55,316.45],
			[84.5,380,140.5,362.45],
			[284.3,380,343.55,362.45]]
		private static const moneyX:Number = 40.45
		private static const moneyY:Number = 364.45
		
			
			
		// []
		override public function enter():void
		{
			mEventModel = stateArgs[0]
			mDirect = stateArgs[1]
			
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var itemList:Array
			var i:int, l:int,value:int
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('events_panel_A') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
				
			btn = new Button('events_ok_btn')
			this.fusion.addElement(btn, 226, 445.45)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('Events').close()
				PlayerManager.getInstance().nextRound(mDirect)
				
				// debug !!
//				DespairUI.getPanel('Events').popup(-1,false, [EventsManager.getInstance().getEventModel()])
			})
				
			mc.txt.text = mEventModel.desc
			
			itemList = mEventModel.itemList
			l = itemList.length
			for(i=0;i<l;i++)
			{
				value = itemList[i]
				if(value!=0)
				{
					mc = getInstance('events_label') as MovieClip
					mc.gotoAndStop(i+1)
					doc.addChild(mc)
					mc.x = positionList[mCount][0]
					mc.y = positionList[mCount][1]
					mc = getInstance('events_value_A') as MovieClip
					mc.bg.gotoAndStop((value > 0) ? 1 : 2)
					mc.txt.text = (value > 0) ? '+' + value : value
					doc.addChild(mc)
					mc.x = positionList[mCount][2]
					mc.y = positionList[mCount][3]
					PlayerManager.getInstance().getPropertyByIndex(i + 1).value += value
					mCount++
				}
			}
			
			value = mEventModel.money
			if(value != 0)
			{
				mc = getInstance('events_value_B') as MovieClip
				mc.bg.gotoAndStop((value > 0) ? 1 : 2)
				mc.txt.text = (value > 0) ? '+' + value : value
				doc.addChild(mc)
				mc.x = moneyX
				mc.y = moneyY
				PlayerManager.getInstance().player.money.value += value
			}

			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}

		
		private var mEventModel:EventModel
		
		private var mCount:int
		
		private var mDirect:Boolean
			
		
		override public function exit():void
		{
			mEventModel = null
		}

	}
}