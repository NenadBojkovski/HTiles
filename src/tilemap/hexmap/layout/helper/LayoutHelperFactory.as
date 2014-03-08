package tilemap.hexmap.layout.helper
{
	import tilemap.hexmap.layout.HexaMapLayout;

	public class LayoutHelperFactory
	{
		public static function createLayoutHelper(layoutType: int): ILayoutHelper
		{
			switch(layoutType)
			{
				case HexaMapLayout.CONVEX_FIRST:
				{
					return new ConvexFirstLayoutHelper();
				}
				case HexaMapLayout.CONCAVE_FIRST:
				{
					return new ConcaveFirstLayoutHelper();
				}
				case HexaMapLayout.DIAMOND_ORIENTATION_UP:
				{
					return new DiamondUpLayoutHelper();
				}
				case HexaMapLayout.DIAMOND_ORIENTATION_DOWN:
				{
					return new DiamondDownLayoutHelper();
				}
				case HexaMapLayout.AXIAL:
				{
					return new AxialLayoutHelper();
				}
				default:
				{
					return null;
				}
			}
		}
	}
}