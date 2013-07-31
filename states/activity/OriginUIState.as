package states.activity
{
	import flash.display.MovieClip;
	
	import carveGirlAssets.SoundAssets;
	
	import models.CookieManager;
	import models.InvestModel;
	import models.PlayerManager;
	
	import org.despair2D.media.SfxManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.events.PanelEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	import states.SceneUIState;
	
	public class OriginUIState extends UIState
	{
		
		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var index:int
			var R:int
			var income:int, expenses:int

			income = PlayerManager.getInstance().player.getIncome()
			expenses = PlayerManager.getInstance().player.getExpenses()
			
			PlayerManager.getInstance().player.money.value += income - expenses
				
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('round_panel_A') as MovieClip
			doc.addChild(mc)
			
			trace(expenses)
			trace(income)
			
			mc.txtA.text = String(expenses)
			mc.txtB.text = String(income)
			
				
			// 盈利
			if(income > expenses)
			{
				mc.type.gotoAndStop(1)
				
				index = ArrayUtil.pullRandom(list)
				mc.itemA.gotoAndStop(index)
				R = int(MathUtil.getRandomBetween(6,10.999));
				mc.txtC.text = '+' + R
				PlayerManager.getInstance().getPropertyByIndex(index).value += R
				
				index = ArrayUtil.pullRandom(list)
				mc.itemB.gotoAndStop(index)
				R = int(MathUtil.getRandomBetween(6,10.999));
				mc.txtD.text = '+' + R
				PlayerManager.getInstance().getPropertyByIndex(index).value += R
			}
			
			// 亏损
			else
			{
				mc.type.gotoAndStop(2)
				
				index = ArrayUtil.pullRandom(list)
				mc.itemA.gotoAndStop(index)
				R = int(MathUtil.getRandomBetween(3,5.999));
				mc.txtC.text = '+' + R
				PlayerManager.getInstance().getPropertyByIndex(index).value += R
				
				index = ArrayUtil.pullRandom(list)
				mc.itemB.gotoAndStop(index)
				R = int(MathUtil.getRandomBetween(3,5.999));
				mc.txtD.text = '+' + R
				PlayerManager.getInstance().getPropertyByIndex(index).value += R
			}
				
			this.fusion.addElement(doc)
			
			btn = new Button('round_ok_btn')
			this.fusion.addElement(btn, 353.7, 399.55)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				onContinue()
			})
			
			btn = new Button('round_close_btn')
			this.fusion.addElement(btn, 677.5, 29.5)
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
			list = null
		}
		
		private var list:Array = [1,2,3,4]
			
			
		private function onContinue():void
		{
			DespairUI.getPanel('Origin').close()
				
			var code:int
			
			code = PlayerManager.getInstance().player.checkGameOver()
			if(code < 0)
			{
				PlayerManager.getInstance().player.round.value++
				if(code == -2)
				{
					return
				}
			}
		
			else
			{
				DespairUI.getPanel('End').popup(-1,true,[code])
				CookieManager.clear()
				PlayerManager.getInstance().player.path.gotoNodeAt(0)
				return
			}
			if(PlayerManager.getInstance().player.remainStep > 0)
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