package tilemap.hexmap.layout.helper
{
	import flash.geom.Point;

	public class ConcaveFirstLayoutHelper implements ILayoutHelper
	{
		public function ConcaveFirstLayoutHelper()
		{
		}
		
		public function getTileOffset(j:int):int
		{
			return j&1;
		}
		
		public function getFartherTriangleOffset(j:int):int
		{
			return getTileOffset(j);
		}
		
		public function getNearerTriangleOffset(j:int):int
		{
			return getTileOffset(j) - 1;
		}
		
		public function getNeighborsOffsets(j: int, isFlatTopped: Boolean): Vector.<Point> {

			if (isFlatTopped) {
				return getTileOffset(j) ? NeighborOffsetsKeeper.EVEN_COLUMN_OFFSET : NeighborOffsetsKeeper.ODD_COLUMN_OFFSET;
			} else {
				return getTileOffset(j) ? NeighborOffsetsKeeper.EVEN_ROW_OFFSET : NeighborOffsetsKeeper.ODD_ROW_OFFSET;
			}
		}
	}
}