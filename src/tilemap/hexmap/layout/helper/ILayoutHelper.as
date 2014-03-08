package tilemap.hexmap.layout.helper
{
	import flash.geom.Point;

	public interface ILayoutHelper
	{
		function getTileOffset(j: int): int;
		function getFartherTriangleOffset(j: int): int;
		function getNearerTriangleOffset(j: int): int;
		function getNeighborsOffsets(j: int, isFlatTopped: Boolean): Vector.<Point>;
	}
}