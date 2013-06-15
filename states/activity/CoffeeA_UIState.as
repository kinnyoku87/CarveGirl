package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class CoffeeA_UIState extends UIState
	{
		public function CoffeeA_UIState()
		{
			super();
		}
		
		
		public static var mLoaded:Boolean
		
		override public function enter(stateArgs:Array):void
		{
			if(!mLoaded)
			{
				LoaderManager.getInstance().getBytesLoader(new (SWFAssets.coffee)).addEventListener(Event.COMPLETE, __onAssetsLoaded)
			}
			else
			{
				__onAssetsLoaded(null)
			}
		}
		
		private function __onAssetsLoaded(e:Event):void
		{
			DespairUI.addMovieClipButtonData('coffee_btn_A', 'coffee_btn_A')
			DespairUI.addMovieClipButtonData('coffee_btn_B', 'coffee_btn_B')
			DespairUI.addMovieClipButtonData('coffee_btn_C', 'coffee_btn_C')
			DespairUI.addMovieClipButtonData('coffee_ok_btn', 'coffee_ok_btn')
			DespairUI.addMovieClipButtonData('coffee_send_btn', 'coffee_send_btn')
			DespairUI.addMovieClipButtonData('coffee_close_btn', 'coffee_close_btn')
			DespairUI.addMovieClipButtonData('coffee_checkBox', 'coffee_checkBox',ButtonType.CHECKBOX | ButtonType.LEAVE_LEAVE)
			mLoaded = true
			
			
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('coffee_panel_A') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			
			// 他人微博
			btn = new Button('coffee_btn_A')
			this.fusion.addElement(btn, 184, 154)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeA').close()
				DespairUI.getPanel('CoffeeB').popup(-1,false,[PlayerManager.getInstance().getCoffeeInfoList()])
			})
				
			// 写微博
			btn = new Button('coffee_btn_B')
			this.fusion.addElement(btn, 184, 234)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeA').close()
				DespairUI.getPanel('CoffeeD').popup(-1,false)
			})
				
			btn = new Button('coffee_btn_C')
			this.fusion.addElement(btn, 184, 314)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeA').close()
				PlayerManager.getInstance().nextRound()
			})
				
			btn = new Button('coffee_close_btn')
			this.fusion.addElement(btn, 337.5, 30.5)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeA').close()
				PlayerManager.getInstance().nextRound()
			})
			
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{

		}
	}
}
