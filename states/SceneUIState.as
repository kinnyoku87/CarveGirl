package states
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	
	import flash.events.Event;
	
	import carveGirlAssets.DataAssets;
	import carveGirlAssets.ImgAssets;
	
	import models.CookieManager;
	import models.PlayerManager;
	
	import org.despair2D.debug.Logger;
	import org.despair2D.map.ViewportData;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.Fusion;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.PanelEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.ui.puppet.ImagePuppet;
	
	public class SceneUIState extends UIState
	{
		
		public static const GAME_START:String = 'gameStart'
		
		public static const STOP:String = 'stop'
		
		
		override public function enter():void
		{
			
//			trace(PlayerManager.getInstance().player.getIncome([1,1,2,2]))
//			trace(PlayerManager.getInstance().player.getExpenses())
			
//			CookieManager.hero.userData = [{name:'AgonyA', type:1, score:14444},
//										{name:'AgonyB', type:1, score:744144},
//										{name:'AgonyC', type:1, score:444433444}]
//			CookieManager.hero.flush()
			
			this.initModel()
			this.initScene()
			this.initListeners()
		}
			
		private function initModel():void
		{
			//trace(PlayerManager.getInstance().player.path.length)
				
			mViewport = new ViewportData(Config.VIEWPORT_WIDTH, Config.VIEWPORT_HEIGHT, Config.SCENE_WIDTH, Config.SCENE_Height)
		}
		
		private function initScene():void
		{
			var doc:DisplayObjectContainerPuppet
			var img:ImagePuppet
			var node:uint
			
			// Content
			mContent = new Fusion
			this.fusion.addElement(mContent)
			
			// Bottom
			img = new ImagePuppet()
			img.embed(ImgAssets.mapBottom)
			mContent.addElement(img)
				
			// Action
			mPlayer = new Fusion()
			img = new ImagePuppet(2, 0, -12)
			img.embed(PlayerManager.getInstance().player.sex == 0 ? ImgAssets.IMG_female : ImgAssets.IMG_male)
			mPlayer.addElement(img)
			node = PlayerManager.getInstance().player.path.currNode
			mContent.addElement(mPlayer, node & 0xFFFF, node >> 16)
				
			// Top
			img = new ImagePuppet()
			img.embed(ImgAssets.mapTop)
			mContent.addElement(img)
			
			// 更新视域
			if(mViewport.seek(mPlayer.x, mPlayer.y, Config.VIEWPORT_WIDTH / 2, Config.VIEWPORT_HEIGHT / 2))
			{
				mContent.move(mViewport.contentX, mViewport.contentY)
			}
		}
			
		private function initListeners():void
		{
			DespairUI.getPanel('Scene').addEventListener(GAME_START,__onGameStart)
		}
		
		override public function exit():void
		{
			DespairUI.getPanel('Scene').removeEventListener(GAME_START,__onGameStart)
			TweenLite.killTweensOf(mPlayer)
			TweenLite.killTweensOf(mContent)
			mViewport = null
			mPlayer = null
			mContent = null
		}
		
		
		
		/////////////////////////////////////////////////////////////////////////////
		
		private var mContent:Fusion
		
		private var mPlayer:Fusion
		
		private var mOldX:Number, mOldY:Number
		
		private var mViewport:ViewportData

		
		
		/////////////////////////////////////////////////////////////////////////////
		
		private function __onGameStart(e:PanelEvent):void
		{
			PlayerManager.getInstance().player.remainStep = e.data ? int(e.data) : PlayerManager.getInstance().player.remainStep
			this.startMove()
		}
		
		private function startMove() : void
		{
			var node:uint
			var dist:Number
			var code:int
			
			dist = PlayerManager.getInstance().player.path.gotoNextNode()
			
			//trace(dist)
			node = PlayerManager.getInstance().player.path.currNode
//			TweenLite.to(mPlayer, dist / Config.MOTION_SPEED, { x:node & 0xFFFF, y:node >> 16,ease:com.greensock.easing.Sine.easeOut, onUpdate:updateViewport, onComplete:function():void
//			{
//				startMove()
//			}})
			
			TweenLite.to(mPlayer, dist / Config.MOTION_SPEED, { x:node & 0xFFFF, y:node >> 16,
														ease:com.greensock.easing.Sine.easeOut, 
													//physics2D:{velocity:300, angle:-60, friction:0.1},
													//	physics2D:{velocity:MathUtil.getRandomBetween(80, 380), angle:MathUtil.getRandomBetween(245, 295), gravity:400},
														onUpdate:updateViewport, onComplete:function():void
			{								
				if(PlayerManager.getInstance().player.path.index == 0)
				{
					Logger.reportWarning('Command', 'Reach', '回到最初...')
				}
				else
				{
					Logger.reportWarning('Command', 'Reach', '当前节点: ' + PlayerManager.getInstance().player.path.index)
				}
				
				--PlayerManager.getInstance().player.remainStep
				
				// 判断是否为起点
				if(PlayerManager.getInstance().player.path.index == 0)
				{
					DespairUI.getPanel('Origin').popup()
				}
				
				// 继续走
				else if(PlayerManager.getInstance().player.remainStep > 0)
				{
					startMove()
				}
				
				else
				{
					DespairUI.getPanel('Scene').dispatchEvent(new PanelEvent(STOP))
				}
					
			}})
		}
		
		private function updateViewport():void
		{
			if(mViewport.seek(mPlayer.x, mPlayer.y, Config.HORIZ_GAP, Config.VERTI_GAP))
			{
				TweenLite.to(mContent, 0.2, {x: mViewport.contentX, y: mViewport.contentY, ease:Linear.easeNone})
				//trace(mViewport.contentX + ' | ' +mViewport.contentY)

			}
		}
		
	}
}