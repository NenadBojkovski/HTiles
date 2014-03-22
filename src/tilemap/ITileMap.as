package tilemap
{
	import flash.geom.Point;

	public interface ITileMap
	{
		function getTile(x: Number, y: Number): Tile;
		function getTileNeighbors(tile:Tile): Vector.<Tile>;
		function getTileCenter(tile: Tile): Point;
		function screenToMapCoordinates(screenPoint: Point): Point;
		function mapToScreenCoordinates(mapPoint: Point): Point;
		function setCustomPivot(x: Number, y: Number): void;
		function get scaleTileVertical(): Number;
		function set scaleTileVertical(value: Number): void;
		function get scaleTileHorizontal(): Number;
		function set scaleTileHorizontal(value: Number): void;
		function set rotation(value: Number): void;
		function get rotation(): Number;
		function get pivotX(): Number;
		function get pivotY(): Number;
		function set pivotAlignment(value: String): void;
		function get pivotAlignment(): String;
	}
}