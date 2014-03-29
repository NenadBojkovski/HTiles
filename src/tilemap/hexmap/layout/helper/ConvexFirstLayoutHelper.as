package tilemap.hexmap.layout.helper
{
	import flash.geom.Point;

	public class ConvexFirstLayoutHelper implements ILayoutHelper
	{
		/*
		* @inheritDoc 
		*/
		public function getTileOffset(j: int): int {
			return -(j&1);
		}
		
		/*
		* @inheritDoc 
		*/
		public function getFartherTriangleOffset(j: int): int {
			return getTileOffset(j) + 1;
		}
		
		/*
		* @inheritDoc 
		*/
		public function getNearerTriangleOffset(j: int): int {
			return getTileOffset(j);
		}
		
		/*
		* @inheritDoc 
		*/
		public function getNeighborsOffsets(j: int, isFlatTopped: Boolean): Vector.<Point> {
			if (isFlatTopped) {
				return getTileOffset(j) ? NeighborOffsetsKeeper.ODD_COLUMN_OFFSET : NeighborOffsetsKeeper.EVEN_COLUMN_OFFSET;
			} else {
				return getTileOffset(j) ? NeighborOffsetsKeeper.ODD_ROW_OFFSET : NeighborOffsetsKeeper.EVEN_ROW_OFFSET;
			}
		}
	}
}