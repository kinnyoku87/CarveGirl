package models
{
	import carveGirlAssets.DataAssets;
	
	import org.despair2D.control.CookieUtil;
	import org.despair2D.debug.Logger;
	import org.despair2D.map.path.PathData;
	import org.despair2D.model.IntProperty;
	import org.despair2D.ui.DespairUI;
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
		
		public function get path() : PathData { return mPath }

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
		
		public var isReadyBuyout:Boolean
		
		// 当前最大用户等级
		public function get maxUserLevel() : int { return Math.max.apply(null, mLevelList) }
		
		
		
		// -1未发生结局
		
		/**
		 * @see	[Origin] #onContinue
		 */
		public function checkGameOver():int
		{
			// 破产
			if(mMoney.value < 10000)
			{
				return 1
			}
			// 团队解散
			if
			(
				((mRound.value == 5) && (mStrategy.value < 10 || mSkill.value < 10 || mProduct.value < 10 || mBusiness.value < 10)) ||
				((mRound.value == 12) && (mStrategy.value < 40 || mSkill.value < 40 || mProduct.value < 40 || mBusiness.value < 40))
			)
			{
				return 2
			}
			// 没有市场的产品
			if
			(
				(mRound.value == 5 && this.numUsers() == 0) ||
				(mRound.value == 10 && this.maxUserLevel <= 1) ||
				(mRound.value == 12 && mBusiness.value < 30)
			)
			{
				return 3
			}
			// 马上上市
			if(isReadyBuyout)
			{
				mMoney.value += mStrategy.value * MathUtil.getRandomBetween(0.8,1.2) * 50000000
				return 6
			}
			// 准备上市
			else if(mRound.value >= 10 && mMoney.value > 50000000 && mProduct.value > 60 && mSkill.value > 70 && mBusiness.value > 50 )
			{
				DespairUI.getPanel('Listing').popup(-1, true)
				return -2
			}
			// 被收购
			if(mRound.value == 10 && mStrategy.value < 50 && mSkill.value > 40 && this.maxUserLevel == 3)
			{
				DespairUI.getPanel('Buyout').popup(-1, true, [100000])
				return -2
			}
			else if(mRound.value == 12 && mProduct.value > 60 && mSkill.value > 50 && this.maxUserLevel == 3)
			{
				DespairUI.getPanel('Buyout').popup(-1, true, [200000])
				return -2
			}
			// 继续发展
			if(mRound.value == 15)
			{
				return 4
			}
			return -1
		}
		public function initialize( data:Object = null ):void
		{
			if(data)
			{
				
			}
			
			else
			{
				mStrategy.value = 3
				mProduct.value = 3
				mSkill.value = 3
				mBusiness.value = 3
				
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
		
		// 用户数目
		public function numUsers( lvlList:Array = null ) : int
		{
			var AY:Array
			var a:Number
			var b:Number
			var c:Number
			
			AY = lvlList ? lvlList : mLevelList
			a = this.getUserTotalByLevel(AY[1])
			b = this.getUserTotalByLevel(AY[2])
			c = this.getUserTotalByLevel(AY[3])
			return (a + b + c)
		}
		
		// 收入
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
		
		// 支出
		public function getExpenses() : Number
		{
			var numEmployee:int
			
			numEmployee = Math.round(mProduct.value / 10 + mSkill.value / 4 + mBusiness.value / 12)
			return (mStrategy.value * 1500 * numEmployee) + int(MathUtil.getRandomBetween(5000, 30000))
		}
		
		// 总分
		public function getScore() : int
		{
			return (mBusiness.value + mStrategy.value + mSkill.value + mProduct.value) * 10000 + this.numUsers()
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
			data.levelList = mLevelList
			
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
			mRemainStep = data.remainStep
			mLevelList = data.levelList
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