package states.activity
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import carveGirlAssets.SWFAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.ScrollPane;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class CoffeeC_UIState extends UIState
	{

		override public function enter():void
		{
			mStateArgs = stateArgs
			
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			
			var txt:TextField
			var correctionX:Number, correctionY:Number
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('coffee_panel_C') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			
			btn = new Button('coffee_ok_btn')
			this.fusion.addElement(btn, 354, 535.1)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeC').close()
				PlayerManager.getInstance().nextRound()
			})
			
			btn = new Button('coffee_close_btn')
			this.fusion.addElement(btn, 677.5, 30.5)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('CoffeeC').close()
				PlayerManager.getInstance().nextRound()
			})
				
			pane = new ScrollPane(650, 335)
			pane.limitLeft = true
			pane.limitRight = true
			this.fusion.addElement(pane, 32 , 87.15)
			doc = new DisplayObjectContainerPuppet()
//			var shape:Shape = new Shape
//			shape.graphics.beginFill(0xFF3333, 0.4)
//			shape.graphics.drawRect(0,0,645,4000)
//			doc.addChild(shape)
			pane.addElement(doc)
			txt = new TextField()
			doc.addChild(txt)
			txt.width = 645
			txt.height = 9000
			txt.defaultTextFormat = new TextFormat(null, 20)
			txt.text = mStateArgs[1]
			txt.multiline = true
			txt.wordWrap = true
			pane.contentHeight = txt.textHeight + 5
				
			pane.addEventListener(ManipulateEvent.START_DRAG, function(e:ManipulateEvent):void
			{
				if (!DespairUI.interactive)
				{
					TweenLite.killTweensOf(pane)
					//trace('interactive false')
				}
			})
			pane.addEventListener(ManipulateEvent.STOP_DRAG, function(e:ManipulateEvent):void
			{
				correctionY = pane.vertiCorrection
				if (correctionY != 0)
				{
					DespairUI.interactive = false
					//trace('interactive false')
					TweenLite.to(pane, 0.6, { y:pane.y + correctionY, 
						ease:Linear.easeNone, 
						onComplete:function():void
						{
							DespairUI.interactive = true
							//trace('interactive true')
						}})
				}
			})
				
			this.fusion.x = (DespairUI.screenWidth - mc.width) / 2
			this.fusion.y = (DespairUI.screenHeight - mc.height) / 2
		}
		
		override public function exit():void
		{
			TweenLite.killTweensOf(pane)
			pane = null
			mStateArgs = null
		}
		
		
		private var pane:ScrollPane
		
		private var mStateArgs:Array
		
	}
}

