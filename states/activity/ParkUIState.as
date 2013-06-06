package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.model.IntProperty;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class ParkUIState extends UIState
	{
		public function ParkUIState()
		{
			super();
		}
		
		
		public static var mLoaded:Boolean
		
		override public function enter():void
		{
			if(!mLoaded)
			{
				LoaderManager.getInstance().getBytesLoader(new (SWFAssets.park)).addEventListener(Event.COMPLETE, __onAssetsLoaded)
			}
			else
			{
				__onAssetsLoaded(null)
			}
		}
		
		private function __onAssetsLoaded(e:Event):void
		{
			DespairUI.addMovieClipButtonData('park_ok_btn', 'park_ok_btn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			mLoaded = true
			
			
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('park_panel') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
				
			btn = new Button('park_ok_btn')
			this.fusion.addElement(btn, 80, 240)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('Park').close()
				DespairUI.getPanel('Dice').popup(-1,true,false)
			})
				
			index = ArrayUtil.pullRandom(list)
			mc.itemA.gotoAndStop(index)
			R = int(MathUtil.getRandomBetween(1,3.999));
			mc.txtA.text = '+' + R
			this.getPropertyByIndex(index).value += R
			
			index = ArrayUtil.pullRandom(list)
			mc.itemB.gotoAndStop(index)
			R = int(MathUtil.getRandomBetween(1,3.999));
			mc.txtB.text = '+' + R
			this.getPropertyByIndex(index).value += R
				
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{
			list = null
		}
		
		private var list:Array = [1,2,3,4]
		
		private function getPropertyByIndex(index:int):IntProperty
		{
			if(index == 1)
			{
				return PlayerManager.getInstance().player.strategy
			}
			else if(index == 2)
			{
				return PlayerManager.getInstance().player.product
			}
			else if(index == 3)
			{
				return PlayerManager.getInstance().player.skill
			}
			else if(index == 4)
			{
				return PlayerManager.getInstance().player.business
			}
			return null
		}
		
	}
}