package states
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import carveGirlAssets.SWFAssets;
	import carveGirlAssets.SoundAssets;
	
	import models.PlayerManager;
	
	import org.despair2D.Despair;
	import org.despair2D.debug.Logger;
	import org.despair2D.media.SfxManager;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.Button;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.CheckBox;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.events.ManipulateEvent;
	import org.despair2D.ui.puppet.DisplayObjectContainerPuppet;
	import org.despair2D.ui.puppet.InputTextPuppet;
	import org.despair2D.ui.puppet.LabelPuppet;
	import org.despair2D.utils.getInstance;
	
	public class EnterUIState extends UIState
	{
		override public function enter():void
		{
			var doc:DisplayObjectContainerPuppet
			var title:MovieClip
			var btn:Button
			var checkBoxA:CheckBox, checkBoxB:CheckBox
			var input:InputTextPuppet
			
			doc = new DisplayObjectContainerPuppet
			
			mBg = getInstance('SWF_enter_BgA') as MovieClip
			doc.addChild(mBg)
			this.fusion.addElement(doc)
				
			PlayerManager.getInstance().player.money.value = 100000
			PlayerManager.getInstance().player.sex = 1
			checkBoxA = new CheckBox('SWF_enter_checkBox', true)
			this.fusion.addElement(checkBoxA, 326, 205)
			checkBoxA.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
				checkBoxB.selected = !checkBoxA.selected
				checkBoxB.interactive = true
				checkBoxA.interactive = false
				PlayerManager.getInstance().player.sex = 1
			})
			checkBoxA.interactive = false
			
			checkBoxB = new CheckBox('SWF_enter_checkBox', false)
			this.fusion.addElement(checkBoxB, 490, 205)
			checkBoxB.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
				checkBoxA.selected = !checkBoxB.selected
				checkBoxB.interactive = false
				checkBoxA.interactive = true
				PlayerManager.getInstance().player.sex = 0
			})
			
			input = new InputTextPuppet(150,26)
			//input.backgroundColor = 0xFFFFFF
			input.maxChars = 6
			input.size = 20
			this.fusion.addElement(input, 255,140)
			input.addEventListener(FocusEvent.FOCUS_IN, function(e:FocusEvent):void
			{
				if(mPrompt)
				{
					mPrompt.kill()
					mPrompt = null
				}
			})
				
			btn = new Button('SWF_enter_startBtn')
			btn.scaleX = 292 / btn.width
			btn.scaleY = 60 / btn.height
			this.fusion.addElement(btn, 195.3, 529.9)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			btn.addEventListener(ManipulateEvent.CLICK, function(e:ManipulateEvent):void
			{
				if(input.text == "" || input.text == null)
				{
					if(!mPrompt)
					{
						mPrompt = new LabelPuppet("<font size = '21' color = '#FF2222'>请输入有效名字</font>")
						fusion.addElement(mPrompt,440,140 )
					}
				}
				else
				{
					PlayerManager.getInstance().player.name = input.text
					DespairUI.getPanel('Enter').close()
					__onClose()
				}
			})
			
			btn = new Button('SWF_enter_heroBtn')
			this.fusion.addElement(btn, 523.75, 529.9)
			btn.addEventListener(ManipulateEvent.PRESS, function(e:ManipulateEvent):void
			{
				SfxManager.getInstance().play(SoundAssets.SN_tap, 1, 1, true)
			})
			
			this.fusion.x = (DespairUI.screenWidth - this.fusion.width) / 2 /// DespairUI.pixelRatio
			this.fusion.y = (DespairUI.screenHeight - this.fusion.height) / 2 /// DespairUI.pixelRatio
				
		}
		
		override public function exit():void
		{
			mBg = null
			mPrompt = null
		}
		
		private var mBg:MovieClip
		
		private var mPrompt:LabelPuppet
		
		
		private function __onClose():void
		{
			PlayerManager.getInstance().player.initialize()
//			Logger.reportMessage('Command', 'sex: ' + PlayerManager.getInstance().player.sex)
//			Logger.reportMessage('Command', 'name: ' + PlayerManager.getInstance().player.name)
			
			DespairUI.getPanel('Scene').popup()
			DespairUI.getPanel('Property').popup()
			DespairUI.getPanel('Introduce').popup()
				
//			DespairUI.getPanel('Origin').popup()
		}
	}
}