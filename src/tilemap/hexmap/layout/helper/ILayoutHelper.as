package tilemap.hexmap.layout.helper
{
	import flash.geom.Point;

	public interface ILayoutHelper
	{
		/*
		 * Returns map tile offset in number of rows/columns relative to the given tile. The usual values are -1, 0, 1. 
		*/
		function getTileOffset(j: int): int;
		
		/*
		* Returns the offset in number of rows/columns of the given hexa tile neighbor covered with farther triangle (measured 
		* from the local covering tile's coordinate system) of the covering tile. The usual values are -1, 0, 1. 
		*/
		function getFartherTriangleOffset(j: int): int;
		
		/*
		* Returns the offset in number of rows/columns of the given hexa tile neighbor covered with nearer triangle (measured 
		* from the local covering tile's coordinate system) of the covering tile. The usual values are -1, 0, 1. 
		*/
		function getNearerTriangleOffset(j: int): int;
		
		/*
		 * Returns the neighbors of the given hexa tile as array of offests from the given hexa tile's positon. 
		 */
		function getNeighborsOffsets(j: int, isFlatTopped: Boolean): Vector.<Point>;
	}
}