package states
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.CookieManager;
	import models.PlayerManager;
	
	import org.despair2D.control.CookieUtil;
	import org.despair2D.control.ICookie;
	import org.despair2D.debug.Logger;
	import org.despair2D.media.MusicManager;
	import org.despair2D.media.SfxManager;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class StartUIState extends UIState
	{
		
		public static var mLoaded:Boolean
		
		override public function enter():void
		{
			if(!mLoaded)
			{
				LoaderManager.getInstance().getBytesLoader(new (SWFAssets.start)).addEventListener(Event.COMPLETE, __onAssetsLoaded)
			}
			else
			{
				__onAssetsLoaded(null)
			}
		}
		
		private function __onAssetsLoaded(e:Event):void
		{
			//trace('start')
			mLoaded = true
			
			var doc:DisplayObjectContainerPuppet
			var title:MovieClip
			var btn:Button
			
			DespairUI.addMovieClipButtonData('SWF_start_Btn','SWF_start_Btn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
				
			doc = new DisplayObjectContainerPuppet
			
			mBg = getInstance('SWF_start_Bg') as MovieClip
			doc.addChild(mBg)
			
			title = getInstance('SWF_start_Envelope') as MovieClip
			doc.addChild(title)
			//title.scaleX = title.scaleY = 0.8
			title.x = 220.4
			title.y = 40
			this.fusion.addElement(doc)
				
			btn = new Button('SWF_start_Btn')
			this.fusion.addElement(btn, 515.75, 659.80)
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
				nextState()
			})
				
			TweenPlugin.activate([BlurFilterPlugin])
			TweenLite.to(mBg, 4.0, {blurFilter:{blurX:15, blurY:15}})
				
				
			if(!MusicManager.getInstance().paused)
			{
				MusicManager.getInstance().play(SoundAssets.SN_bg, 0, 1, true)
			}
		}
		
		override public function exit():void
		{
			TweenLite.killTweensOf(mBg)
			mBg = null
		}
		
		private var mBg:MovieClip
		
		
		private function nextState():void
		{
			DespairUI.getPanel('Start').close()
			DespairUI.getPanel('Bg').popup()
			
			DespairUI.getPanel('Enter').popup()
//			var cookie:ICookie = CookieManager.cookie
//			if(cookie.size == 0)
//			{
//				DespairUI.getPanel('Enter').popup()
//			}
//			else
//			{
//				PlayerManager.getInstance().player.setData(cookie.userData)
//				DespairUI.getPanel('Scene').popup()
//				DespairUI.getPanel('Property').popup()
//				DespairUI.getPanel('Dice').popup()
//			}
		}
	}
}