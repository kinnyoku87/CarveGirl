package states
{
	import flash.display.MovieClip;
	
	import carveGirlAssets.SoundAssets;
	
	import models.CookieManager;
	import models.PlayerManager;
	
	import org.despair2D.media.SfxManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class IntroduceUIState extends UIState
	{
		public function IntroduceUIState()
		{
			super();
		}
		
		override public function enter():void
		{
			//SfxManager.getInstance().play(SoundAssets.sn, 1, 1, true)
			
			var doc:DisplayObjectContainerPuppet
			var title:MovieClip
			var btn:Button
			var bg:MovieClip

			doc = new DisplayObjectContainerPuppet
			
			bg = getInstance('SWF_enter_BgB') as MovieClip
			doc.addChild(bg)
			this.fusion.addElement(doc)
				
			bg.playerName.text = PlayerManager.getInstance().player.name
			bg.txtA.text = '+' + String(PlayerManager.getInstance().player.strategy.value)
			bg.txtB.text = '+' + String(PlayerManager.getInstance().player.product.value)
			bg.txtC.text = '+' + String(PlayerManager.getInstance().player.skill.value)
			bg.txtD.text = '+' + String(PlayerManager.getInstance().player.business.value)
				
			btn = new Button('SWF_enter_okBtn')
			this.fusion.addElement(btn, 227.55, 451.25)
			btn.addEventListener(ManipulateEvent.CLICK, __onClose)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
				
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
					
			// 实时记录 !!
			CookieManager.flush()
		}
		
		private function __onClose(e:ManipulateEvent):void
		{
			//CookieManager.flush()
			DespairUI.getPanel('Introduce').close()
			DespairUI.getPanel('Dice').popup(-1,false)
		}
		
	}
}