package
{
	import com.sociodox.theminer.TheMiner;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import carveGirlAssets.DataAssets;
	
	import models.EventsManager;
	import models.PlayerManager;
	
	import org.despair2D.Despair;
	import org.despair2D.control.KeyboardManager;
	import org.despair2D.ui.DespairUI;
	
	import states.BgUIState;
	import states.DiceUIState;
	import states.EnterUIState;
	import states.IntroduceUIState;
	import states.PropertyUIState;
	import states.SceneUIState;
	import states.StartUIState;
	import states.activity.CoffeeA_UIState;
	import states.activity.CoffeeB_UIState;
	import states.activity.CoffeeC_UIState;
	import states.activity.CoffeeD_UIState;
	import states.activity.EventsUIState;
	import states.activity.ParkUIState;
	import states.activity.UserA_UIState;
	import states.activity.UserB_UIState;
	import states.activity.UserC_UIState;
	import states.activity.UserD_UIState;
	import states.activity.UserE_UIState;
	import states.activity.UserF_UIState;
	
	// com.pamakids.SafeBookForKids
	[SWF(width="1024",height="768",frameRate="60",backgroundColor="0x0")]
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
			DespairUI.startup(true, 1024, 768)
			this.initModel()
			this.initPanel()
			
		}
		
		private function initModel():void
		{
			var data:XML = XML(new DataAssets.DATA_events)
			EventsManager.getInstance().initializeEvents(data)
			data = XML(new DataAssets.DATA_phase)
			EventsManager.getInstance().initializePhase(data)
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
			DespairUI.registerPanel('UserA',     UserA_UIState)
			DespairUI.registerPanel('UserB',     UserB_UIState)
			DespairUI.registerPanel('UserC',     UserC_UIState)
			DespairUI.registerPanel('UserD',     UserD_UIState)
			DespairUI.registerPanel('UserE',     UserE_UIState)
			DespairUI.registerPanel('UserF',     UserF_UIState)
			DespairUI.registerPanel('Events',    EventsUIState)
			DespairUI.registerPanel('CoffeeA',   CoffeeA_UIState)
			DespairUI.registerPanel('CoffeeB',   CoffeeB_UIState)
			DespairUI.registerPanel('CoffeeC',   CoffeeC_UIState)
			DespairUI.registerPanel('CoffeeD',   CoffeeD_UIState)
				
//			DespairUI.getPanel('Start').popup()
				
//			PlayerManager.getInstance()
//			DespairUI.getPanel('Events').popup(-1,false,[EventsManager.getInstance().getEventModel()])
				
			KeyboardManager.getInstance().initialize()
			KeyboardManager.getInstance().getState().addPressListener('A',function():void
			{
				DespairUI.getPanel('Events').close()
				EventsManager.getInstance().startPhaseEvent()
			})
				
		}
	}
}