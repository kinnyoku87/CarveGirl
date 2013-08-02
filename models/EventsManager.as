package models
{
	import org.despair2D.debug.Logger;
	import org.despair2D.ui.DespairUI;
	import org.despair2D.utils.ArrayUtil;

	public class EventsManager
	{
		public function EventsManager()
		{
		}
		
		private static var mInstance:EventsManager
		public static function getInstance() : EventsManager
		{
			return mInstance ||= new EventsManager
		}
		
		
		public function initializeEvents( data:XML ) : void
		{
			//trace(data)
			var modelA:EnsureEventModel
			var modelB:EventModel
			var item:XMLList
			var l:int, i:int
			
			// 确定发生事件
			mNumEnsureEvents = data.ensureEvent.length()
			for(i=0;i<mNumEnsureEvents;i++)
			{
				modelA = new EnsureEventModel()
				modelA.fromXMLList(XMLList(data.ensureEvent[i]), data.ensureEvent[i].id)
				mEnsureEventList[i] = modelA
//				trace(modelA)
			}
			
			// 随机事件
			l = data.event.length()
			for(i=0;i<l;i++)
			{
				modelB = new EventModel()
				modelB.fromXMLList(XMLList(data.event[i]), data.event[i].id)
				mEventList[i] = modelB
				//trace(modelB)
			}
		}
		
		public function initializePhase( data:XML ) : void
		{
			var i:int, l:int, id:int
			var list:XMLList
			var AY:Array
			var itemA:EventModel
			var itemB:InvestModel
			
			l = data.event.length()
			for(i=0;i<l;i++)
			{
				id = data.event[i].id - 1
				if(!mPhaseList[id])
				{
					mPhaseList[id] = AY = []
				}
				else
				{
					AY = mPhaseList[id]
				}
				if(data.event[i].type.toString() == "news")
				{
					itemA = new EventModel()
					itemA.fromXMLList(XMLList(data.event[i]), data.event[i].id)
					AY.push(itemA)
				}
				else
				{
					itemB = new InvestModel()
					itemB.desc = data.event[i].desc
					itemB.money = data.event[i].money
					AY.push(itemB)
				}
				
				
			}
			//trace(mPhaseList)
		}
		
		public function getEventModel() : EventModel
		{
			var modelB:EventModel
			var modelA:EnsureEventModel
			var index:int, i:int, l:int, roundT:int
			var list:Array
			var round:int
			
			if(mNumFinishedEnsureEvents < mNumEnsureEvents)
			{
				modelA = mEnsureEventList[mNumFinishedEnsureEvents++]
				modelB = modelA.getRandomEventModel()
					
				Logger.reportMessage('Events', '获取Ensure事件，id(' + modelB.id + ')')
			}
			else
			{
				roundT = (PlayerManager.getInstance().player.round.value < 2) ? 2 : PlayerManager.getInstance().player.round.value
				list = []
				l = mEventList.length
				for(i=0;i<l;i++)
				{
					modelB = mEventList[i]
					if(roundT >= modelB.roundMin && roundT <= modelB.roundMax)
					{
						list.push(modelB)
					}
				}
				l = list.length
				index = int(l * Math.random())
				modelB = list[index]
				
				// 检测不可重复使用
				if(!modelB.reuse)
				{
					index = mEventList.indexOf(modelB)
					mEventList.splice(index, 1)
				}
				
				Logger.reportMessage('Events', '获取事件，id(' + modelB.id + ')...随机总数(' + l + ')...reuse(' + modelB.reuse + ')')
			}
			
			return modelB
		}
		
		public function startPhaseEvent():void
		{
			var l:int 
			var AY:Array
			var item:*
			
			l = mPhaseList.length
			if(mCurrPhase >= l)
			{
				return
			}
			AY = mPhaseList[mCurrPhase++]
			item = ArrayUtil.pullRandom(AY, false)
				
			if(item is EventModel)
			{
				DespairUI.getPanel('Events').popup(-1,false,[item, true])
			}
			else if(item is InvestModel)
			{
				if((item as InvestModel).money > 0)
				{
					DespairUI.getPanel('PhaseB').popup(-1,false,[item])
				}
				else
				{
					DespairUI.getPanel('PhaseA').popup(-1,false,[item])
				}
			}
			else
			{
				DespairUI.getPanel('Dice').popup(-1,false)
			}
			
			Logger.reportMessage('PHASE', '获取Phase事件，id(' + mCurrPhase + ')')
		}
		
		public function reset():void{
			mNumFinishedEnsureEvents = mCurrPhase = 0
		}
		
		
		private var mEnsureEventList:Array = []
			
		private var mEventList:Array = []
		
		private var mNumEnsureEvents:int, mNumFinishedEnsureEvents:int

		private var mPhaseList:Array = []
		
		private var mCurrPhase:int
	}
}