package
{
	import com.sociodox.theminer.TheMiner;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.despair2D.Despair;
	import org.despair2D.ui.DespairUI;
	
	import states.LoadingUIState;
	
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
				
			// despair2D - ui初期化
			DespairUI.startup(true, 1024, 768)
			
			// loading...
			DespairUI.registerPanel('Loading',  LoadingUIState)
			DespairUI.getPanel('Loading').popup()
		}
	
	}
}