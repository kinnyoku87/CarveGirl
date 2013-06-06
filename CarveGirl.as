package
{
	import com.sociodox.theminer.TheMiner;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.despair2D.Despair;
	import org.despair2D.ui.DespairUI;
	
	import states.BgUIState;
	import states.DiceUIState;
	import states.EnterUIState;
	import states.IntroduceUIState;
	import states.PropertyUIState;
	import states.SceneUIState;
	import states.StartUIState;
	import states.activity.ParkUIState;
	
	[SWF(width="1024",height="768",frameRate="60")]
	public class CarveGirl extends Sprite
	{
		public function CarveGirl()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, __onAddedToStage)
		}
		
		private function __onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, __onAddedToStage)
				
			// TheMiner
			var tm:TheMiner = new TheMiner()
			this.addChild(tm)
			
			// despair2D初期化
			Despair.startup(this.stage)
			
			// keyboard初期化
//			KeyboardManager.getInstance().initialize()
				
			// despair2D - ui初期化
			DespairUI.startup(true, 132)
			
			
			this.initAssets()
			this.initPanel()
		}
		
		private function initAssets():void
		{
			
		}
		
		private function initPanel():void
		{
			DespairUI.registerPanel('Start',	 StartUIState)
			DespairUI.registerPanel('Bg',   	 BgUIState)
			DespairUI.registerPanel('Enter', 	 EnterUIState)
			
			DespairUI.registerPanel('Scene', 	 SceneUIState)
			DespairUI.registerPanel('Property',  PropertyUIState)
			DespairUI.registerPanel('Introduce', IntroduceUIState)
			DespairUI.registerPanel('Dice',      DiceUIState)
				
			DespairUI.registerPanel('Park',      ParkUIState)
				
			DespairUI.getPanel('Start').popup()
		}
	}
}