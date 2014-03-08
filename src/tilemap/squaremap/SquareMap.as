package tilemap.squaremap
{
	import flash.geom.Point;
	
	import tilemap.Tile;
	import tilemap.TileMap;

	public class SquareMap extends TileMap
	{
		private var _tileSideLenght: Number;
		private var _tileHorizontalSideLenght: Number;
		private var _tileVerticalSideLenght: Number;
		private var _hasDiagonalNeighbors: Boolean; 
		
		public function SquareMap(tileSideLenght: Number, hasDiagonalNeighbors:Boolean = true) {
			_tileSideLenght = _tileHorizontalSideLenght = _tileVerticalSideLenght = tileSideLenght;
			_hasDiagonalNeighbors = hasDiagonalNeighbors;
		}
		
		public function get tileSideLenght():Number
		{
			return _tileSideLenght;
		}

		override public function set scaleTileVertical(value:Number):void
		{
			super.scaleTileVertical = value;
			_tileVerticalSideLenght = _tileSideLenght * value;
		}

		override public function set scaleTileHorizontal(value:Number):void
		{
			super.scaleTileHorizontal = value;
			_tileHorizontalSideLenght = _tileSideLenght * value;
		}
		
		override public function getTile(x:Number, y:Number):Tile {
			var tile: Tile = new Tile();
			var rotatedPoint: Point = inversePointRotation(x,y); 
			tile.i = floor((rotatedPoint.x + halfLenghtHorizontalSide)/_tileHorizontalSideLenght);
			tile.j = floor((rotatedPoint.y + halfLengthtVerticalSide)/_tileVerticalSideLenght);
			return tile;
		}
		
		override public function getNeighbors(tile:Tile):Vector.<Tile> {
			var neighbors: Vector.<Tile> = new Vector.<Tile>();
			for (var i: int = -1; i < 2; ++i) {
				for (var j: int = -1; j < 2; ++j) {
					if (_hasDiagonalNeighbors && ((i != 0) || (j != 0))  || (abs(i) != abs(j))) {
						neighbors.push( new Tile(tile.i + i, tile.j +j));
					}
				}
			}
			return neighbors;
		}
		
		override public function getCenter(tile:Tile):Point {
			var x: Number = tile.i * _tileHorizontalSideLenght;
			var y: Number = tile.j * _tileVerticalSideLenght;
			return rotatePoint(x, y);
		}
		
		private function get halfLenghtHorizontalSide(): Number {
			return _tileHorizontalSideLenght * 0.5;
		}
		
		private function get halfLengthtVerticalSide(): Number {
			return _tileVerticalSideLenght * 0.5;
		}
	}
}