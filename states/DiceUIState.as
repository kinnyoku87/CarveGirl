package states
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import org.despair2D.debug.Logger;
	import org.despair2D.media.SfxManager;
	import org.despair2D.model.RangeWrapProperty;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.events.PanelEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class DiceUIState extends UIState
	{
		
		override public function enter():void
		{
			
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('dice_bg') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
			
			mDice = getInstance('dice_dice') as MovieClip
			doc.addChild(mDice)
			mDice.x = 53
			mDice.y = 53
			mDice.gotoAndStop(1)
				
			btn = new Button('dice_go')
			this.fusion.addElement(btn, 103.6, 16)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				//trace('dice')
				btn.interactive = false
				SfxManager.getInstance().play(SoundAssets.SN_dice, 1, 1, true)
				gamble()
					
			})
				
			this.fusion.x = DespairUI.screenWidth - (80 + this.fusion.width)//) * DespairUI.pixelRatio
			this.fusion.y = 40
			
			mWrapRange = new RangeWrapProperty(1,1,6.999)
			mWrapRange.binding(function():void
			{
				mDice.gotoAndStop(int(mWrapRange.value))
			}, false)
		}
		
		override public function exit():void
		{
			TweenLite.killTweensOf(this.fusion)
			TweenLite.killTweensOf(mDice)
			TweenLite.killTweensOf(mWrapRange)
			mWrapRange.dispose()
			mWrapRange = null
			mDice = null
		}
		
		
		private var mDice:MovieClip
		
		public var mPoint:int
		
		private var mWrapRange:RangeWrapProperty
		
		
		
		////////////////////////////////////////////////////////////////
		
		private function gamble() : void
		{
			var point:int = 1
			var R:Number = MathUtil.getRandomBetween(1200, 2400)
			R = R - R % 360
			TweenLite.to(mDice, 3, {rotation:R,ease:Quart.easeInOut})
			TweenLite.to(mWrapRange, 3, {value:MathUtil.getRandomBetween(43,73),ease:Quart.easeInOut,onComplete:function():void
			{
				Logger.reportMessage('Command', '点数: ' + int(mWrapRange.value))
				DespairUI.getPanel('Scene').dispatchEvent(new PanelEvent(SceneUIState.GAME_START, int(mWrapRange.value)))
				gambleComplete()
			}})
		}
		
		private function gambleComplete() : void
		{
			TweenLite.to(this.fusion, 0.7, {alpha:0.05, ease:Linear.easeNone, onComplete:function():void
			{
				DespairUI.getPanel('Dice').close()
			}})
		}
		
	}
}