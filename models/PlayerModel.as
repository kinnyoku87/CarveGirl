package models
{
	import carveGirlAssets.DataAssets;
	
	import org.despair2D.control.CookieUtil;
	import org.despair2D.debug.Logger;
	import org.despair2D.map.path.PathData;
	import org.despair2D.model.IntProperty;
	import org.despair2D.utils.MathUtil;

	public class PlayerModel
	{
		public function PlayerModel()
		{
			mItemList = [mStrategy, mProduct, mSkill, mBusiness]
				
			mPath = new PathData
				
			// 导入路径数据
			mPath.fromByteArray(new (DataAssets.DATA_path))
			mPath.looped = true
		}
		
		
		public static const USER_TOTAL:int = 538000000
		
		
		
		
		public function get path() : PathData 
		{
			return mPath
		}

		public function get name() : String { return mName }
		public function set name( v:String ) : void { mName = v }
		
		public function get sex() : int { return mSex }
		public function set sex( v:int ) : void
		{
			mSex = v 
			Logger.reportMessage('Command', '性别: ' + mSex)
		}
		
		public function get round() : IntProperty { return mRound }
		
		public function get strategy() : IntProperty { return mStrategy }
		
		public function get product() : IntProperty { return mProduct }

		public function get skill() : IntProperty { return mSkill }
		
		public function get business() : IntProperty { return mBusiness }
		
		public function get money() : IntProperty { return mMoney }
		
		public function get itemList():Array { return mItemList }
		
		public function get remainStep() : int { return mRemainStep }
		public function set remainStep( v:int ) : void { mRemainStep = v }
		
		// 等级列表
		public function get levelList():Array { return mLevelList }
		
		public var motionCount:int
		
		
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
		
		public function getIncome( lvlList:Array = null ):int
		{
			var AY:Array
			var a:Number
			var b:Number
			var c:Number
			
			AY = lvlList ? lvlList : mLevelList
			a = this.getUserTotalByLevel(AY[1]) * 0.3 
			b = this.getUserTotalByLevel(AY[2]) * 0.5
			c = this.getUserTotalByLevel(AY[3]) * 0.05
			return (a + b + c) * mStrategy.value * MathUtil.getRandomBetween(0.8,1.2) / 1000
		}
		
		public function getExpenses() : Number
		{
			var numEmployee:int
			
			numEmployee = Math.round(mProduct.value / 10 + mSkill.value / 4 + mBusiness.value / 12)
			return (mStrategy.value * 1500 * numEmployee) + int(MathUtil.getRandomBetween(5000, 30000))
		}
		
		public function getData():Object
		{
			var data:Object
			
			data = {}
			data.round = mRound.value
			data.strategy = mStrategy.value
			data.product = mProduct.value
			data.skill = mSkill.value
			data.business = mBusiness.value
			data.money = mMoney.value
				
			data.name = mName
			data.sex = mSex
			data.motionCount = motionCount
			data.pathIndex = this.path.index
			
			return data
		}
		
		public function setData( data:Object ) : void
		{
			mRound.value = data.round
			mStrategy.value = data.strategy 
			mProduct.value = data.product
			mSkill.value = data.skill
			mBusiness.value=data.business
			mMoney.value=data.money 
				
			mName=data.name 
			mSex=data.sex 
			motionCount = data.motionCount
			this.path.gotoNodeAt(data.pathIndex)
		}
		
		
		/////////////////////////////////////////////////////////
		
		private var mPath:PathData

		private var mSex:int = 1 // 0女 1男。。别多想。。
			
		private var mName:String
		
		private var mRound:IntProperty = new IntProperty(1)
			
		private var mStrategy:IntProperty = new IntProperty(3)
		
		private var mProduct:IntProperty = new IntProperty(3)
		
		private var mSkill:IntProperty = new IntProperty(3)
		
		private var mBusiness:IntProperty = new IntProperty(3)
		
		private var mItemList:Array = []
			
		private var mLevelList:Array = [0,0,0,0]
			
		private var mMoney:IntProperty = new IntProperty(100000)
			
		private var mRemainStep:int

			
		//////////////////////////////////////////////////////////////////////
			
			
			
		private function getUserTotalByLevel( level:int ) : Number
		{
			if(level == 0)
			{
				return 0
			}
			else if(level == 1)
			{
				return 0.5 * USER_TOTAL * 0.556 
			}			
			else if(level == 2)
			{
				return 0.75 * USER_TOTAL * 0.375
			}
			return 1 * USER_TOTAL * 0.057
		}
			
		
	}
}