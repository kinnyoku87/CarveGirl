package states.activity
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	
	import carveGirlAssets.ImgAssets;
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.CookieManager;
	import models.InvestModel;
	import models.PlayerManager;
	
	import org.despair2D.media.MusicManager;
	import org.despair2D.media.SfxManager;
	import org.despair2D.model.IntProperty;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.CheckBox;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.Fusion;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.events.PanelEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.ui.puppet.ImagePuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class EndUIState extends UIState
	{
		
		
		
		/**
		 *  [●●●Type]
		 *  1. 破产
		 *  2. 团队解散
		 *  3. 没有市场的产品
		 *  4. 继续发展
		 *  5. 被收购
		 *  6. 上市
		 */
		override public function enter():void
		{
//			DespairUI.getPanel('Scene').popup(0)
//			DespairUI.getPanel('Property').popup(0)

			var doc:DisplayObjectContainerPuppet = new DisplayObjectContainerPuppet(false)
			var shape:Shape = new Shape
			mGraphic = shape.graphics
			mGraphic.beginFill(0x0, 1)
			mGraphic.drawRect(0,0,DespairUI.screenWidth, DespairUI.screenHeight)
			doc.addChild(shape)
			this.fusion.addElement(doc)
			
			var img:ImagePuppet = new ImagePuppet()
			img.embed(ImgAssets.IMG_text, false)
			this.fusion.addElement(img)
			img.alpha = 0
				
			TweenPlugin.activate([ColorTransformPlugin])
			TweenLite.from(shape, 3.5, {alpha:0.01, onComplete:function():void
			{
				DespairUI.getPanel('Scene').close()
				DespairUI.getPanel('Property').close()
			}})
			TweenLite.to(img, 2.0, {delay:1.7, alpha:1, onComplete:function():void
			{
				MusicManager.getInstance().play(SoundAssets.SN_endingBg, 0, 0.7, true)
				TweenLite.to(img, 1.3, {alpha:0, onComplete:function():void
				{
					img.kill()
				}})
				
				var imgB:ImagePuppet = new ImagePuppet()
				imgB.embed(ImgAssets.IMG_city)
				fusion.addElement(imgB)
				
				TweenLite.from(imgB, 2, {delay:0.6, alpha:0.01, onComplete:addEndPanel})
			}})
			
		}
		
		private var mGraphic:Graphics
		
//		private function updateAll():void
//		{
//			mGraphic.beginFill(0, 0.1)
//			mGraphic.drawRect(0,0,DespairUI.screenWidth, DespairUI.screenHeight)
//		}
		private var ffusion:Fusion
		private function addEndPanel() : void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			ffusion = new Fusion()
			this.fusion.addElement(ffusion)
			var obj:Object = {name:PlayerManager.getInstance().player.name ? PlayerManager.getInstance().player.name : '???',
							type:this.stateArgs[0],
							score:PlayerManager.getInstance().player.getScore()}
			PlayerManager.getInstance().heroList.push(obj)
				
			PlayerManager.getInstance().sortedHeroList()
			CookieManager.flushHero()
				
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('end_state') as MovieClip
			doc.addChild(mc)
			mc.stateMc.gotoAndStop(this.stateArgs[0])
			if(this.stateArgs[0] == 6)
			{
				mc.stateMc.money.text = PlayerManager.getInstance().player.money.value.toString()
			}
			ffusion.addElement(doc)
			mc.scoreTxt.text = PlayerManager.getInstance().player.getScore().toString()
			var ranking:int = PlayerManager.getInstance().heroList.indexOf(obj)
			mc.rankingTxt.text = ranking < 0 ? '>99' : ranking + 1
			
			mc.bgA.gotoAndStop(1)
			mc.bgB.gotoAndStop(1)
				
			btn = new Button('end_againBtn')
			ffusion.addElement(btn, 183.4, 528.9)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
//				DespairUI.getPanel('BreakUp').close()
				trace('end_againBtn')
				DespairUI.killAllPanels()
				DespairUI.getPanel('Start').popup()
			})
				
			btn = new Button('end_heroBtn')
			ffusion.addElement(btn, 519.75, 528.9)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				trace('end_heroBtn')
				DespairUI.getPanel('Hero').popup()
			})
				
			btn = new Button('end_weiboBtn')
			ffusion.addElement(btn, 592.55, 265.7)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				trace('end_weiboBtn')
				
			})
				
			DespairUI.getPanel('Hero').addEventListener(PanelEvent.POPUP, onPopup)
			DespairUI.getPanel('Hero').addEventListener(PanelEvent.CLOSE, onClose)
				
			CookieManager.clear()	
				
			ffusion.x = (DespairUI.screenWidth - ffusion.width) / 2
			ffusion.y = (DespairUI.screenHeight - ffusion.height) / 2
		}
		
		override public function exit():void
		{
			DespairUI.getPanel('Hero').removeEventListener(PanelEvent.POPUP, onPopup)
			DespairUI.getPanel('Hero').removeEventListener(PanelEvent.CLOSE, onClose)
		}
		
		private function onPopup(e:PanelEvent):void
		{
			ffusion.visible = false
		}
		
		private function onClose(e:PanelEvent):void
		{
			ffusion.visible = true
		}
	}
}

