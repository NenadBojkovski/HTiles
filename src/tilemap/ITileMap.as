package tilemap
{
	import flash.geom.Point;

	public interface ITileMap
	{
		function getTile(x: Number, y: Number): Tile;
		function getNeighbors(tile:Tile): Vector.<Tile>;
		function getCenter(tile: Tile): Point;
		function get scaleTileVertical(): Number;
		function set scaleTileVertical(value: Number): void;
		function get scaleTileHorizontal(): Number;
		function set scaleTileHorizontal(value: Number): void;
		function set rotation(value: Number): void;
		function get rotation(): Number;
	}
}