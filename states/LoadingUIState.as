package states
{
	import carveGirlAssets.DataAssets;
	import carveGirlAssets.ImgAssets;
	
	import models.CookieManager;
	import models.EventsManager;
	import models.PlayerManager;
	
	import org.despair2D.control.DelayManager;
	import org.despair2D.ui.ButtonType;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.puppet.ImagePuppet;
	
	import states.activity.Buyout_UIState;
	import states.activity.CoffeeA_UIState;
	import states.activity.CoffeeB_UIState;
	import states.activity.CoffeeC_UIState;
	import states.activity.CoffeeD_UIState;
	import states.activity.EndUIState;
	import states.activity.EventsUIState;
	import states.activity.HeroUIState;
	import states.activity.ListingB_UIState;
	import states.activity.ListingUIState;
	import states.activity.OriginUIState;
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
		
		
		public const LOADING_TIME:int = 2
		
		
		override public function enter():void
		{
			var img:ImagePuppet
			
			img = new ImagePuppet()
			img.embed(ImgAssets.IMG_loading, false)
			this.fusion.addElement(img)
				
			//this.initAssets()
			this.initModel()
			this.initPanel()
			this.initUIData()
			this.initSave()
			DelayManager.getInstance().delayedCall(LOADING_TIME, function():void
			{
				mDelayComplete = true
				if(mDelayComplete && mLoadComplete)
				{
					nextUIState()
				}
			})
		}
		
		override public function exit():void
		{
			
		}
		
		
		
		private var mDelayComplete:Boolean, mLoadComplete:Boolean = true
		
		private var mTotal:int
		
		
		
		private function initModel():void
		{
			SWF_enter_BgA
			SWF_enter_BgB
			SWF_enter_checkBox
			SWF_enter_heroBtn
			SWF_enter_okBtn
			SWF_enter_startBtn
			
			leftBackToMain
			leftCheckBox
			leftPanelA
			leftPanelB
			leftPanelC
			leftSound
			leftTakeBack
			
			SWF_start_Bg
			SWF_start_Btn
			SWF_start_Envelope
			SWF_start_resume_Btn
			
			dice_bg
			dice_dice
			dice_go
			
			user_close_btn
			user_interview_btn
			user_ok_btn
			user_panel_A
			user_panel_B
			user_panel_C
			user_panel_D
			user_panel_E
			user_panel_F
			user_popularize_btn
			
			phase_cancel_btn
			phase_ok_btn
			phase_panel_A
			phase_panel_B
			
			park_ok_btn
			park_panel
			
			round_close_btn
			round_ok_btn
			round_panel_A
			
			events_label
			events_ok_btn
			events_panel_A
			events_value_A
			events_value_B
			
			coffee_btn_A
			coffee_btn_B
			coffee_btn_C
			coffee_checkBox
			coffee_close_btn
			coffee_item_btn
			coffee_ok_btn
			coffee_panel_A
			coffee_panel_B
			coffee_panel_C
			coffee_panel_D
			coffee_send_btn
			
			end_state
			end_hero
			end_heroBtn
			end_againBtn
			end_weiboBtn
			end_backBtn
			end_panelA
			end_panelB
			end_panelC
			end_okBtn
			end_cancelBtn
			
			
			var data:XML = XML(new DataAssets.DATA_events)
			EventsManager.getInstance().initializeEvents(data)
			data = XML(new DataAssets.DATA_phase)
			EventsManager.getInstance().initializePhase(data)
		}
		
//		private function initAssets():void
//		{
//			var list:Array = SWFAssets.list
//			var l:int = list.length
//			while(--l>-1)
//			{
//				LoaderManager.getInstance().getLoader(SWFAssets.path + list[l], 0, true)
//			}
//				
//			LoaderManager.getInstance().addCompleteListener(function():void
//			{
//				LoaderManager.getInstance().reomveCompleteListener(arguments.callee)
//				Logger.reportMessage('Command', 'Loading All Complete...', true)
//				
//				initUIData()
//				initPanel()
//				mLoadComplete = true
//				if(mDelayComplete && mLoadComplete)
//				{
//					nextUIState()
//				}
//			})
//		}
		
		private function initUIData():void
		{
			DespairUI.addMovieClipButtonData('SWF_start_Btn','SWF_start_Btn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('SWF_start_resume_Btn','SWF_start_resume_Btn',ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			
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
				
			DespairUI.addMovieClipButtonData('round_ok_btn', 'round_ok_btn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('round_close_btn', 'round_close_btn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
				
			DespairUI.addMovieClipButtonData('end_backBtn', 'end_backBtn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('end_againBtn', 'end_againBtn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('end_heroBtn', 'end_heroBtn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('end_weiboBtn', 'end_weiboBtn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('end_okBtn', 'end_okBtn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
			DespairUI.addMovieClipButtonData('end_cancelBtn', 'end_cancelBtn', ButtonType.BUTTON | ButtonType.LEAVE_LEAVE)
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
			DespairUI.registerPanel('Origin',    OriginUIState)
				
			DespairUI.registerPanel('End',       EndUIState)
			DespairUI.registerPanel('Hero',      HeroUIState)
			DespairUI.registerPanel('Buyout',    Buyout_UIState)
			DespairUI.registerPanel('Listing',   ListingUIState)
			DespairUI.registerPanel('ListingB',  ListingB_UIState)
		}
		
		private function initSave():void
		{
			var key:String
			
			CookieManager.cookie
			CookieManager.hero
				
			//trace('hero')
			for each(var item:* in CookieManager.hero.userData)
			{
				PlayerManager.getInstance().heroList.push(item)
			}
				
			for(key in CookieManager.cookie.userData)
			{
				trace(key + ' | ' + CookieManager.cookie.userData[key])
			}
			
		}
		
		private function nextUIState():void
		{
			DespairUI.getPanel('Loading').close()
			DespairUI.getPanel('Start').popup()
			
//			DespairUI.getPanel('End').popup(-1,true,[6])
//			DespairUI.getPanel('Hero').popup(-1,true,[6])
//			DespairUI.getPanel('Buyout').popup(-1,true,[34343])
//			DespairUI.getPanel('ListingB').popup(-1,true)
			
//			DespairUI.getPanel('PhaseB').popup()
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