package states
{
	import carveGirlAssets.ImgAssets;
	
	import org.despair2D.ui.UIState;
	import org.despair2D.ui.puppet.ImagePuppet;
	
	public class BgUIState extends UIState
	{
		override public function enter(stateArgs:Array):void
		{
			var img:ImagePuppet
			
			img = new ImagePuppet()
			img.embed(ImgAssets.IMG_city)
			this.fusion.addElement(img)
		}
	}
}