package models
{
	import carveGirlAssets.DataAssets;
	
	import org.despair2D.Observer;
	import org.despair2D.debug.Logger;
	import org.despair2D.model.IntProperty;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.ui.events.PanelEvent;
	import org.despair2D.utils.ArrayUtil;
	import org.despair2D.utils.XMLUtil;
	
	import states.SceneUIState;

	public class PlayerManager
	{
		
		public function PlayerManager()
		{
			mPlayer = new PlayerModel
			this.initializeUserData()
			this.initializeCoffee()
			DespairUI.getPanel('Scene').addEventListener(SceneUIState.STOP, __onScenePlayerStop)
		}
		
		
		// 0:起点
		// 1:儿童用户
		// 2:青年用户
		// 3:中年用户
		// 4:老年用户
		// 5:咖啡厅
		// 6:意外
		// 7:公园
		public static const pathUserData:Array = [0, 1, 3, 5, 6, 2, 7, 4, 3, 6,
												1, 3, 6, 2, 4, 5, 1, 3, 6, 2,
												4, 6, 1, 3, 7, 4, 2, 1, 6, 2,
												3, 5, 4, 1, 7, 6, 2, 4]
		// 阶段性事件
		public static const PHASE_INTERVAL:int = 8
		
		
		public static const pathUserDataB:Array = ['起点','儿童用户','青年用户','中年用户','老年用户','咖啡厅','事件','公园']
			
		
		private static var mInstance:PlayerManager
		public static function getInstance() : PlayerManager
		{
			return mInstance ||= new PlayerManager
		}
		
		
		public function get player() : PlayerModel
		{
			return mPlayer
		}
		
		public function nextRound(direct:Boolean = false):void
		{
			if(direct)
			{
				DespairUI.getPanel('Dice').popup(-1,false)
			}
			else
			{
				++mMotionCount
				Logger.reportMessage('numPhase', '步数' + mMotionCount)
				if((mMotionCount % PHASE_INTERVAL) == 0)
				{
					EventsManager.getInstance().startPhaseEvent()
				}
				else
				{
					DespairUI.getPanel('Dice').popup(-1,false)
				}
			}
		}
		
		private function initializeUserData():void
		{
			var data:XML = XML(new DataAssets.DATA_userData)
			var l:int, i:int
			var item:XMLList
			var group:UserDataQroup
			
			l = data.children().length()
			mUserDataGroupList = []
			
			for(i=0;i<l;i++)
			{
				mUserDataGroupList[i] = group = new UserDataQroup()
				item = data..low[i].children()
				group.low = XMLUtil.getObjectFromXMLList(item)
					
				item = data..medium[i].children()
				group.medium = XMLUtil.getObjectFromXMLList(item)
					
				item = data..high[i].children()
				group.high = XMLUtil.getObjectFromXMLList(item)
			}
		}
		
		private function initializeCoffee():void
		{
			var data:XML = XML(new DataAssets.DATA_coffee)
			var l:int, i:int
			l = data.article.length()
			for(i=0;i<l;i++)
			{
				mCoffeeInfoList[i] = [String(data.article[i].name[0]), String(data.article[i].content[0])]
			}
		}
		
		public function getPropertyByIndex(index:int):IntProperty
		{
			return mPlayer.itemList[index - 1]
		}
		
		// 随机获取3个
		public function getCoffeeInfoList() : Array
		{
			var result:Array, listT:Array
			
			result = []
			listT = mCoffeeInfoList.concat()
			result.push(ArrayUtil.pullRandom(listT))
			result.push(ArrayUtil.pullRandom(listT))
			result.push(ArrayUtil.pullRandom(listT))
			return result
		}

	
		private var mPlayer:PlayerModel
		
		private var mUserDataGroupList:Array
		
		private var mCoffeeInfoList:Array = []
		
		private var mMotionCount:int
		
		
		///////////////////////////////////////////////////////////////
		
		private function __onScenePlayerStop(e:PanelEvent):void
		{
			trace(this.player.getUserDataPrompt())
			
			//DespairUI.getPanel('UserA').popup(-1,false,[[3,3,3,3], 10000, 1, 2])
			
			this.checkNodeInfo()
		}
		
		// 根据格子代号获取当前的信息
		private function checkNodeInfo() : void
		{
			var code:int
			
//			DespairUI.getPanel('CoffeeA').popup(-1,false)
//			return
			
			code = pathUserData[mPlayer.path.index]
				
			// 起点事件
			if(code == 0)
			{
				DespairUI.getPanel('Park').popup(-1,false)
			}
			
			// 用户事件
			else if(code >=1 && code <=4)
			{
				this.handleUserActivity(code - 1)
			}
			
			// 咖啡厅事件
			else if(code == 5)
			{
				DespairUI.getPanel('CoffeeA').popup(-1,false)
			}
			
			// 意外事件
			else if(code == 6)
			{
				DespairUI.getPanel('Events').popup(-1,false,[EventsManager.getInstance().getEventModel()])
			}
			
			// 公园事件
			else if(code == 7)
			{
				DespairUI.getPanel('Park').popup(-1,false)
			}
		}
		
		private function handleUserActivity( index:int ):void
		{
			var group:UserDataQroup
			var level:int, i:int, ii:int, l:int
			var obj:Object
			
			group = mUserDataGroupList[index]
			level = mPlayer.levelList[index]
			
			// 已满级，无需推广
			if(level >= 3)
			{
				DespairUI.getPanel('UserC').popup(-1,false,[null, obj.money, level, index])
				return
			}
			
			switch(level)
			{
				case 0:
					obj = group.low
					break;
				case 1:
					obj = group.medium
					break;
				case 2:
					obj = group.high
					break;
				default:
					break;
			}
			
			var strategy:int = obj.strategy
			var product:int = obj.product
			var skill:int = obj.skill
			var business:int = obj.business
			var money:int = obj.money
				
			// 满足推广条件
			if((strategy == 0 || strategy <= mPlayer.strategy.value) && 
				(product == 0 || product <= mPlayer.product.value) && 
				(skill == 0 || skill <= mPlayer.skill.value) && 
				(business == 0 || business <= mPlayer.business.value) &&
				(money == 0 || money <= mPlayer.money.value))
			{
				DespairUI.getPanel('UserA').popup(-1,false,[[strategy, product, skill, business], money, level, index])
			}
			
			// 不满足
			else
			{
				DespairUI.getPanel('UserB').popup(-1,false,[[strategy, product, skill, business], money, level, index])
			}
		}
		
	}
}