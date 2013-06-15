package models
{
	import org.despair2D.control.CookieUtil;
	import org.despair2D.debug.Logger;
	import org.despair2D.map.path.PathData;
	import org.despair2D.model.IntProperty;

	public class PlayerModel
	{
		public function PlayerModel()
		{
			mItemList = [mStrategy, mProduct, mSkill, mBusiness]
			
		}
		
		
		public function get path() : PathData { return mPath ||= new PathData }
		
		public function get round() : int { return mRound }
		public function set round( v:int ) : void { mRound = v }
		
		public function get name() : String { return mName }
		public function set name( v:String ) : void { mName = v }
		
		public function get sex() : int { return mSex }
		public function set sex( v:int ) : void
		{
			mSex = v 
			Logger.reportMessage('Command', '性别: ' + mSex)
		}
		
		public function get strategy() : IntProperty { return mStrategy }
		
		public function get product() : IntProperty { return mProduct }

		public function get skill() : IntProperty { return mSkill }
		
		public function get business() : IntProperty { return mBusiness }
		
		public function get money() : IntProperty { return mMoney }
		
		public function get itemList():Array { return mItemList }
		
		public function get levelList():Array { return mLevelList }
		
		
		public function initialize( data:Object = null ):void
		{
			if(data)
			{
				
			}
			
			else
			{
				var l:int = 8
				var R:Number
				while(--l>-1)
				{
					R = Math.random()
					if(R < 0.25)
					{
						mStrategy.value++
					}
					else if(R < 0.5)
					{
						mProduct.value++
					}
					else if(R < 0.75)
					{
						mSkill.value++
					}
					else
					{
						mBusiness.value++
					}
				}
			}
		}	
		
		public function getUserDataPrompt():String
		{
			return PlayerManager.pathUserDataB[PlayerManager.pathUserData[this.path.index]] + '(' + this.path.index + ')'
		}
		
		public function getData():Object
		{
			var data:Object
			
			data = {}
			data.round = mRound
			data.strategy = mStrategy.value
			data.product = mProduct.value
			data.skill = mSkill.value
			data.business = mBusiness.value
			data.money = mMoney.value
			data.name = mName
			data.sec = mSex
			data.pathIndex = mPath.index
				
			return data
		}
		
		public function setData( data:Object ) : void
		{
			mRound = data.round
			mStrategy.value = data.strategy 
			mProduct.value = data.product
			mSkill.value = data.skill
			mBusiness.value=data.business
			mMoney.value=data.money 
			mName=data.name 
			mSex=data.sec 
			this.path.gotoNodeAt(data.pathIndex)
		}
		
		
		
		private var mPath:PathData
		
		private var mRound:int = 1
		
		private var mSex:int = 1 // 0女 1男。。别多想。。
			
		private var mName:String
		
		private var mStrategy:IntProperty = new IntProperty(3)
		
		private var mProduct:IntProperty = new IntProperty(3)
		
		private var mSkill:IntProperty = new IntProperty(3)
		
		private var mBusiness:IntProperty = new IntProperty(3)
		
		private var mItemList:Array = []
			
		private var mLevelList:Array = [0,0,0,0]
			
		private var mMoney:IntProperty = new IntProperty(100000)
	
	}
}