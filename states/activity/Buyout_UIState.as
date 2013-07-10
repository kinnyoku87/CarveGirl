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
	
	public class Buyout_UIState extends UIState
	{
		
		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('end_panelA') as MovieClip
			doc.addChild(mc)
			mc.moneyTxt.text = this.stateArgs[0]
			this.fusion.addElement(doc)
				
			btn = new Button('end_okBtn')
			this.fusion.addElement(btn, 37.05, 242.65)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				trace('end_okBtn')
				PlayerManager.getInstance().player.money.value += PlayerManager.getInstance().player.strategy.value * MathUtil.getRandomBetween(0.8,1.2) * stateArgs[0]
				DespairUI.getPanel('Buyout').close()
				DespairUI.getPanel('End').popup(-1,true,[5])
			})
			
			btn = new Button('end_cancelBtn')
			this.fusion.addElement(btn, 232.9, 242.65)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				trace('end_cancelBtn')
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
			DespairUI.getPanel('Buyout').close()
				
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

