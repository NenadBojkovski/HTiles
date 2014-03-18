package tilemap.hexmap
{
	import tilemap.ITileMap;
	import tilemap.hexmap.layout.FlatToppedHexMap;
	import tilemap.hexmap.layout.HexaMapLayout;
	import tilemap.hexmap.layout.PointyToppedHexMap;
	import tilemap.hexmap.layout.helper.ILayoutHelper;
	import tilemap.hexmap.layout.helper.LayoutHelperFactory;

	public class HexMapFactory 
	{
		public static function creatHexMap(hexRadius: Number, mapStyle: int, mapLayout: int): ITileMap
		{
			var hexMap: ITileMap;
			var helper: ILayoutHelper = LayoutHelperFactory.createLayoutHelper(mapLayout);
			if (mapStyle == HexMap.FLAT_TOPPED) {
				hexMap = new FlatToppedHexMap(hexRadius, helper);
			} else {
				hexMap = new PointyToppedHexMap(hexRadius, helper);
			}
			return hexMap;
		}
	}
		
}