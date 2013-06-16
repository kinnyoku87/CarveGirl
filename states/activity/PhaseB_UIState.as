package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.InvestModel;
	import models.PlayerManager;
	
	import org.despair2D.media.SfxManager;
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
	
	public class PhaseB_UIState extends UIState
	{
		public function PhaseB_UIState()
		{
			super();
		}
		
		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			var model:InvestModel
			
			model = stateArgs[0]
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('phase_panel_B') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			mc.desc.text = model.desc
			mc.txt.text = model.money.toString()
				
			btn = new Button('phase_ok_btn')
			this.fusion.addElement(btn, 128.5, 270.15)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('PhaseB').close()
				PlayerManager.getInstance().nextRound()
			})
			
			btn = new Button('phase_cancel_btn')
			this.fusion.addElement(btn, 322.4, 270.15)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('PhaseB').close()
				PlayerManager.getInstance().nextRound(true)
			})
				
			PlayerManager.getInstance().player.money.value += model.money
				
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{
			
		}
		
	}
}

