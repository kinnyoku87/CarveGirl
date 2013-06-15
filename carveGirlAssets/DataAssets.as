package carveGirlAssets
{
	public class DataAssets
	{
		public function DataAssets()
		{
		}
		
		[Embed(source="data/02.path",mimeType = "application/octet-stream")] 
		public static var DATA_path:Class
		
		[Embed(source="data/userData.xml",mimeType = "application/octet-stream")] 
		public static var DATA_userData:Class
		
		[Embed(source="data/events.xml",mimeType = "application/octet-stream")] 
		public static var DATA_events:Class
		
		[Embed(source="data/coffee.xml",mimeType = "application/octet-stream")] 
		public static var DATA_coffee:Class
		
		[Embed(source="data/phase.xml",mimeType = "application/octet-stream")] 
		public static var DATA_phase:Class
	}
}