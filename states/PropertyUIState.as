package states
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.debug.Logger;
	import org.despair2D.media.MusicManager;
	import org.despair2D.media.SfxManager;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.CheckBox;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.Fusion;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.layout.SpaceType;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.utils.getInstance;
	
	public class PropertyUIState extends UIState
	{

		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			
			this.fusion.spaceHeight = DespairUI.screenHeight// * DespairUI.pixelRatio
			
			
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('leftPanelA') as MovieClip
			doc.addChild(mc)
			mc.x = 30
			mc.y = 40
			this.fusion.addElement(doc)
			
			PlayerManager.getInstance().player.money.binding(__onBindingE,true)
			PlayerManager.getInstance().player.strategy.binding(__onBindingA,true)
			PlayerManager.getInstance().player.product.binding(__onBindingB,true)
			PlayerManager.getInstance().player.skill.binding(__onBindingC,true)
			PlayerManager.getInstance().player.business.binding(__onBindingD,true)
				
			FA = new Fusion()
			doc = new DisplayObjectContainerPuppet()
			var mcB:MovieClip = getInstance('leftPanelB') as MovieClip	
			doc.addChild(mcB)
			mcB.playerName.text = PlayerManager.getInstance().player.name
			mcB.year.text = PlayerManager.getInstance().player.round
			FA.addElement(doc)
				
			checkBox = new CheckBox('leftCheckBox')
			checkBox.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			checkBox.addEventListener(Event.CHANGE,function():void
			{
				if(checkBox.selected)
				{
					doc.visible = false
					createFusionB()
				}
				else
				{
					doc.visible = true
					mFusionB.kill()
				}
			})
			FA.addElement(checkBox)
			
			this.fusion.addElement(FA, 48, -40, SpaceType.LEFT | SpaceType.BOTTOM)	
			
		}
		
		override public function exit():void
		{
			PlayerManager.getInstance().player.money.unbinding(__onBindingE)
			PlayerManager.getInstance().player.strategy.unbinding(__onBindingA)
			PlayerManager.getInstance().player.product.unbinding(__onBindingB)
			PlayerManager.getInstance().player.skill.unbinding(__onBindingC)
			PlayerManager.getInstance().player.business.unbinding(__onBindingD)
			mc = null
			FA = null
			mFusionB = null
			checkBox = null
		}
		
		private var mc:MovieClip
		private var FA:Fusion
		private var mFusionB:Fusion
		private var checkBox:CheckBox
		
		
		
		
		private function createFusionB():void
		{
			var doc:DisplayObjectContainerPuppet
			var mc:MovieClip
			var btn:Button
			var cb:CheckBox
			
			mFusionB = new Fusion()
			doc = new DisplayObjectContainerPuppet()
			mc = getInstance('leftPanelC') as MovieClip	
			doc.addChild(mc)
			mFusionB.addElement(doc,0,-1)
				
			btn = new Button('leftBackToMain')
			mFusionB.addElement(btn, 138.4, 25.85)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				Logger.reportMessage('Command', 'back to main...')
				DespairUI.killAllPanels()
				PlayerManager.getInstance().player.path.gotoNodeAt(0)
				DespairUI.getPanel('Start').popup()
			})
				
			cb = new CheckBox('leftSound', !SfxManager.getInstance().enabled)
			mFusionB.addElement(cb, 297.6, 25.85)
			cb.addEventListener(Event.CHANGE, function(e:Event):void
			{
				Logger.reportMessage('Command', '声音:' + !cb.selected)
				if(!cb.selected)
				{
					SfxManager.getInstance().setEnable()
					MusicManager.getInstance().reset()
					SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
				}
				else
				{
					SfxManager.getInstance().setDisable()
					MusicManager.getInstance().paused = true
					
				}
			})
				
			btn = new Button('leftTakeBack')
			mFusionB.addElement(btn, 603.2, 25.9)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				checkBox.selected = !checkBox.selected
			})
				
			FA.addElementAt(mFusionB,-2)	
		}
		
		
		private function __onBindingE():void
		{
			mc.txtE.text = String(PlayerManager.getInstance().player.money.value)
		}
		
		private function __onBindingA():void
		{
			mc.txtA.text = String(PlayerManager.getInstance().player.strategy.value)
		}
		
		private function __onBindingB():void
		{
			mc.txtB.text = String(PlayerManager.getInstance().player.product.value)
		}
		
		private function __onBindingC():void
		{
			mc.txtC.text = String(PlayerManager.getInstance().player.skill.value)
		}
		
		private function __onBindingD():void
		{
			mc.txtD.text = String(PlayerManager.getInstance().player.business.value)
		}
	}
}