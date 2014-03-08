package tilemap.hexmap.layout.helper
{
	import flash.geom.Point;

	public class DiamondUpLayoutHelper implements ILayoutHelper
	{
		public function DiamondUpLayoutHelper()
		{
		}
		
		public function getTileOffset(j:int):int
		{
			return j;
		}
		
		public function getFartherTriangleOffset(j:int):int
		{
			return 0;
		}
		
		public function getNearerTriangleOffset(j:int):int
		{
			return -1;
		}
		
		public function getNeighborsOffsets(j: int, isFlatTopped: Boolean): Vector.<Point> {
			return NeighborOffsetsKeeper.DIAMOND_UP;
		}
	}
}