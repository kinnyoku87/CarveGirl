package states.activity
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
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
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.MathUtil;
	import org.despair2D.utils.getInstance;
	
	public class HeroUIState extends UIState
	{

		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var typeMap:Array
			
			typeMap = ['破产','团队解散','没有市场的产品','继续发展','被收购','上市']
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('end_hero') as MovieClip
			doc.addChild(mc)
			this.fusion.addElement(doc)
				
			var list:Array
			var i:int, l:int
			
			list = PlayerManager.getInstance().heroList
			l = Math.min(list.length, 5)
			for(i = 0;i<l;i++)
			{
				mc['name' + (i+1)].text = list[i].name
				mc['type' + (i+1)].text = typeMap[list[i].type - 1]
				mc['score' + (i+1)].text = list[i].score
			}
				
			
			btn = new Button('end_backBtn')
			this.fusion.addElement(btn, 208.55, 499.6)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				DespairUI.getPanel('Hero').close()
				trace('end_backBtn')
			})
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2
		}
		
		override public function exit():void
		{
			
		}
		
	}
}
