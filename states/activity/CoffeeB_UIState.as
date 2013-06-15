package states.activity
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import models.PlayerManager;
	
	import org.despair2D.ui.Button;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.layout.SpaceType;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.ui.puppet.LabelPuppet;
	import org.despair2D.utils.getInstance;
	
	public class CoffeeB_UIState extends UIState
	{
		public function CoffeeB_UIState()
		{
			super();
		}
		
		override public function enter(stateArgs:Array):void
		{
			DespairUI.addMovieClipButtonData('coffee_item_btn', 'coffee_item_btn')
			
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			var label:LabelPuppet
			var css:TextFormat = new TextFormat(null, 28)
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('coffee_panel_B') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			
			btn = new Button('coffee_item_btn')
			this.fusion.addElement(btn, 25, 136 - 45)
			label = new LabelPuppet(stateArgs[0][0][0])
			label.textField.setTextFormat(css)
			this.fusion.addElement(label, 0,0,SpaceType.A_HORIZ_MIDDLE | SpaceType.A_VERTI_MIDDLE)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				propertyChange()
				DespairUI.getPanel('CoffeeB').close()
				DespairUI.getPanel('CoffeeC').popup(-1,false,stateArgs[0][0])
			})
			
			btn = new Button('coffee_item_btn')
			this.fusion.addElement(btn, 25, 232.95 - 45)
			label = new LabelPuppet(stateArgs[0][1][0])
			label.textField.setTextFormat(css)
			this.fusion.addElement(label, 0,0,SpaceType.A_HORIZ_MIDDLE | SpaceType.A_VERTI_MIDDLE)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				propertyChange()
				DespairUI.getPanel('CoffeeB').close()
				DespairUI.getPanel('CoffeeC').popup(-1,false,stateArgs[0][1])
			})
			
			btn = new Button('coffee_item_btn')
			this.fusion.addElement(btn, 25, 330.95 - 45)
			label = new LabelPuppet(stateArgs[0][2][0])
			label.textField.setTextFormat(css)
			this.fusion.addElement(label, 0,0,SpaceType.A_HORIZ_MIDDLE | SpaceType.A_VERTI_MIDDLE)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				propertyChange()
				DespairUI.getPanel('CoffeeB').close()
				DespairUI.getPanel('CoffeeC').popup(-1,false,stateArgs[0][2])
			})
			
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{

		}
		
		private function propertyChange():void
		{
			PlayerManager.getInstance().player.skill.value += 3
			PlayerManager.getInstance().player.product.value += 3
		}
	}
}

