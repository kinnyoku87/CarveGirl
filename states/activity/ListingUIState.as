package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.CookieManager;
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
	import org.despair2D.ui.events.PanelEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	import states.SceneUIState;
	
	public class ListingUIState extends UIState
	{
		
		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('end_panelB') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			
			btn = new Button('end_okBtn')
			this.fusion.addElement(btn, 37.05, 242.65)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				trace('准备上市.')
				PlayerManager.getInstance().player.isReadyBuyout = true
				onContinue()
			})
			
			btn = new Button('end_cancelBtn')
			this.fusion.addElement(btn, 232.9, 242.65)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				onContinue()
			})
			
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{
			
		}
		
		
		private function onContinue():void
		{
			DespairUI.getPanel('Listing').close()
			
			// 第十五轮
			if(PlayerManager.getInstance().player.round.value == 15)
			{
				DespairUI.getPanel('End').popup(-1,true,[4])
			}
			else if(PlayerManager.getInstance().player.remainStep > 0)
			{
				DespairUI.getPanel('Scene').dispatchEvent(new PanelEvent(SceneUIState.GAME_START))
			}
			else
			{
				PlayerManager.getInstance().nextRound()
			}
		}
		
	}
}

