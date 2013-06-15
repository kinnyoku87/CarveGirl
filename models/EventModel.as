package models
{
	public class EventModel
	{
		public function EventModel()
		{
		}
		
		public var itemList:Array = []
		
		public var money:int
		
		public var reuse:Boolean
		
		public var desc:String
		
		public var id:String
		
		public var roundMin:int, roundMax:int
		
		
		public function toString() : String
		{
			return this.itemList + ' | ' 
					this.money + ' | ' + 
					this.desc + ' | ' + 
					this.reuse + ' | ' +
					this.roundMin + ' | ' + 
					this.roundMax + ' | '
		}
		
		
		public function fromXMLList( data:XMLList, id:String ) : void
		{
			var str:String
			var arr:Array
			
			this.id = id
			this.itemList = [int(data.strategy), int(data.product), int(data.skill), int(data.business)]
			this.money = data.money
			this.desc = data.desc
			this.reuse = (data.reuse == 'true')
			
			if(data.hasOwnProperty('range'))
			{
				str = data.range
				arr = str.split('-')
				this.roundMin = arr[0]
				this.roundMax = (arr[1] == '') ? Config.MAX_ROUND : arr[1]
			}
		}
	}
}