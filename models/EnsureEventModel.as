package models
{
	public class EnsureEventModel
	{
		public function EnsureEventModel()
		{
		}
		
		
		public function getRandomEventModel() : EventModel
		{
			return mList[int(mList.length * Math.random())]
		}
		
		public function addEventModel( model:EventModel ) : void
		{
			mList.push(model)
		}
		
		public function toString() : String
		{
			var str:String = 'id(' + mId + ')\n' 
			var item:*
			
			for each(item in mList)
			{
				str += item.toString() + '\n'
			}
			return str
		}
		
		public function fromXMLList( data:XMLList, id:String ) : void
		{
			var i:int, l:int
			var model:EventModel
			
			mId = id
			l = data.event.length()
			for(i=0;i<l;i++)
			{
				model = new EventModel()
				model.fromXMLList(XMLList(data.event[i]), id)
				mList[i] = model
			}
		}
		
		
		private var mList:Array = []
		
		private var mId:String
	}
}