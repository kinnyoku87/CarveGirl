package states
{
	import flash.events.Event;
	
	import carveGirlAssets.DataAssets;
	import carveGirlAssets.ImgAssets;
	import carveGirlAssets.SWFAssets;
	
	import models.EventsManager;
	
	import org.despair2D.Despair;
	import org.despair2D.control.DelayManager;
	import org.despair2D.debug.Logger;
	import org.despair2D.resource.ILoader;
	import org.despair2D.resource.LoaderManager;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.puppet.ImagePuppet;
	
	import states.activity.CoffeeA_UIState;
	import states.activity.CoffeeB_UIState;
	import states.activity.CoffeeC_UIState;
	import states.activity.CoffeeD_UIState;
	import states.activity.EventsUIState;
	import states.activity.ParkUIState;
	import states.activity.PhaseA_UIState;
	import states.activity.PhaseB_UIState;
	import states.activity.UserA_UIState;
	import states.activity.UserB_UIState;
	import states.activity.UserC_UIState;
	import states.activity.UserD_UIState;
	import states.activity.UserE_UIState;
	import states.activity.UserF_UIState;
	
	public class LoadingUIState extends UIState
	{
		public function LoadingUIState()
		{
			super();
		}
		
		
		public const LOADING_TIME:int = 3
		
		
		override public function enter():void
		{
			var img:ImagePuppet
			
			img = new ImagePuppet()
			img.embed(ImgAssets.IMG_loading, false)
			this.fusion.addElement(img)
				
			this.initAssets()
			this.initModel()
			DelayManager.getInstance().delayedCall(LOADING_TIME, function():void
			{
				mDelayComplete = true
				if(mDelayComplete && mLoadComplete)
				{
					nextUIState()
				}
			})
		}
		
		private function nextUIState():void
		{
			DespairUI.getPanel('Loading').close()
			DespairUI.getPanel('Start').popup()
		}
		
		override public function exit():void
		{
			
		}
		
		
		
		private var mDelayComplete:Boolean, mLoadComplete:Boolean
		
		private var mTotal:int
		
		
		
		private function initModel():void
		{
			var data:XML = XML(new DataAssets.DATA_events)
			EventsManager.getInstance().initializeEvents(data)
			data = XML(new DataAssets.DATA_phase)
			EventsManager.getInstance().initializePhase(data)
		}
		
		private function initAssets():void
		{
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.start))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.enter))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.left))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.dice))
				
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.user))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.phase))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.coffee))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.events))
			LoaderManager.getInstance().getBytesLoader(new (SWFAssets.park))
				
				
			mTotal = LoaderManager.getInstance().totalValue
			LoaderManager.getInstance().addCompleteListener(function():void
			{
				LoaderManager.getInstance().reomveCompleteListener(arguments.callee)
				Logger.reportMessage('Command', 'Loading All Complete...', true)
				
				initUIData()
				initPanel()
				mLoadComplete = true
				if(mDelayComplete && mLoadComplete)
				{
					nextUIState()
				}
			})
		}
		
		private function initUIData():void
		{
			DespairUI.addMovieClipButtonData('SWF_start_Btn','SWF_start_Btn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			
			DespairUI.addMovieClipButtonData('SWF_enter_heroBtn','SWF_enter_heroBtn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('SWF_enter_startBtn','SWF_enter_startBtn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('SWF_enter_okBtn','SWF_enter_okBtn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('SWF_enter_checkBox','SWF_enter_checkBox',ButtonType.CHECKBOX | ButtonType.LEAVE_LEAVE)

			DespairUI.addMovieClipButtonData('leftCheckBox', 'leftCheckBox', ButtonType.CHECKBOX | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('leftSound', 'leftSound', ButtonType.CHECKBOX | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('leftBackToMain', 'leftBackToMain', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('leftTakeBack', 'leftTakeBack', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
				
			DespairUI.addMovieClipButtonData('dice_go', 'dice_go', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
				
			DespairUI.addMovieClipButtonData('user_interview_btn','user_interview_btn',ButtonType.BUTTON|ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('user_ok_btn','user_ok_btn',ButtonType.BUTTON|ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('user_popularize_btn','user_popularize_btn',ButtonType.BUTTON|ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('user_close_btn','user_close_btn',ButtonType.BUTTON|ButtonType.LEAVE_LEAVE)
			
			DespairUI.addMovieClipButtonData('phase_ok_btn', 'phase_ok_btn')
			DespairUI.addMovieClipButtonData('phase_cancel_btn', 'phase_cancel_btn')
				
			DespairUI.addMovieClipButtonData('coffee_item_btn', 'coffee_item_btn')
			DespairUI.addMovieClipButtonData('coffee_btn_A', 'coffee_btn_A')
			DespairUI.addMovieClipButtonData('coffee_btn_B', 'coffee_btn_B')
			DespairUI.addMovieClipButtonData('coffee_btn_C', 'coffee_btn_C')
			DespairUI.addMovieClipButtonData('coffee_ok_btn', 'coffee_ok_btn')
			DespairUI.addMovieClipButtonData('coffee_send_btn', 'coffee_send_btn')
			DespairUI.addMovieClipButtonData('coffee_close_btn', 'coffee_close_btn')
			DespairUI.addMovieClipButtonData('coffee_checkBox', 'coffee_checkBox',ButtonType.CHECKBOX | ButtonType.LEAVE_LEAVE)
				
			DespairUI.addMovieClipButtonData('events_ok_btn', 'events_ok_btn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
				
			DespairUI.addMovieClipButtonData('park_ok_btn', 'park_ok_btn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
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
			DespairUI.registerPanel('PhaseA',    PhaseA_UIState)
			DespairUI.registerPanel('PhaseB',    PhaseB_UIState)
			
			//DespairUI.getPanel('PhaseB').popup()
			//			PlayerManager.getInstance()
			//			DespairUI.getPanel('Events').popup(-1,false,[EventsManager.getInstance().getEventModel()])
			
			//			KeyboardManager.getInstance().initialize()
			//			KeyboardManager.getInstance().getState().addPressListener('A',function():void
			//			{
			//				DespairUI.getPanel('Events').close()
			//				DespairUI.getPanel('PhaseA').close()
			//				DespairUI.getPanel('PhaseB').close()
			//				EventsManager.getInstance().startPhaseEvent()
			//			})
			
		}
		
		
		
	}
}