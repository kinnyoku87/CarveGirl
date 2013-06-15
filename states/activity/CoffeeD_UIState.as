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
	import org.despair2D.ui.CheckBox;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class CoffeeD_UIState extends UIState
	{
		public function CoffeeD_UIState()
		{
			super();
		}
		
		override public function enter(stateArgs:Array):void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			var checkBox:CheckBox
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('coffee_panel_D') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			
			checkBox = new CheckBox('coffee_checkBox')
			this.fusion.addElement(checkBox, 79.5, 439)
			
			btn = new Button('coffee_close_btn')
			this.fusion.addElement(btn, 677.5, 30.45)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeD').close()
				PlayerManager.getInstance().nextRound()
			})
			
			btn = new Button('coffee_send_btn')
			this.fusion.addElement(btn, 208.4, 508.1)
				
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{
			
		}
		
	}
}

