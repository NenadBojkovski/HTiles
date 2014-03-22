package tilemap.squaremap
{
	import flash.geom.Point;
	
	import tilemap.PivotAlignment;
	import tilemap.Tile;
	import tilemap.TileMap;

	public class SquareMap extends TileMap
	{
		protected var _tileSideLenght: Number;
		protected var _tileHorizontalSideLenght: Number;
		protected var _tileVerticalSideLenght: Number;
		protected var _hasDiagonalNeighbors: Boolean; 
		
		public function SquareMap(tileSideLenght: Number, hasDiagonalNeighbors:Boolean = true) {
			_tileSideLenght = _tileHorizontalSideLenght = _tileVerticalSideLenght = tileSideLenght;
			_hasDiagonalNeighbors = hasDiagonalNeighbors;
			setCenterOffset(centerOffsetX, centerOffsetY);
		}
		
		public function get tileSideLenght():Number
		{
			return _tileSideLenght;
		}

		override public function set scaleTileVertical(value:Number):void
		{
			super.scaleTileVertical = value;
			_tileVerticalSideLenght = _tileSideLenght * value;
			setCenterOffset(centerOffsetX, centerOffsetY);
		}

		override public function set scaleTileHorizontal(value:Number):void
		{
			super.scaleTileHorizontal = value;
			_tileHorizontalSideLenght = _tileSideLenght * value;
			setCenterOffset(centerOffsetX, centerOffsetY);
		}
		
		override public function getTile(x:Number, y:Number):Tile {
			var tile: Tile = new Tile();
			var rotatedPoint: Point = rotatePoint(x,y); 
			tile.i = floor((rotatedPoint.x + _totalOffest.x)/_tileHorizontalSideLenght);
			tile.j = floor((rotatedPoint.y + _totalOffest.y)/_tileVerticalSideLenght);
			return tile;
		}
		
		override public function getTileNeighbors(tile:Tile):Vector.<Tile> {
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
		
		override public function getTileCenter(tile:Tile):Point {
			var x: Number = tile.i * _tileHorizontalSideLenght - _pivotOffset.x;
			var y: Number = tile.j * _tileVerticalSideLenght - _pivotOffset.y;
			return inversePointRotation(x, y);
		}
		
		protected function get halfLenghtHorizontalSide(): Number {
			return _tileHorizontalSideLenght * 0.5;
		}
		
		protected function get halfLengthtVerticalSide(): Number {
			return _tileVerticalSideLenght * 0.5;
		}
		
		protected function get centerOffsetX(): Number {
			return halfLenghtHorizontalSide;
		}
		
		protected function get centerOffsetY(): Number {
			return halfLengthtVerticalSide;
		}
		
		override protected function updatePivot(): void { 
			switch(_pivotAlignment)
			{
				case PivotAlignment.CORNER_0: {
					_pivotOffset.x = -halfLenghtHorizontalSide;
					_pivotOffset.y = -halfLengthtVerticalSide;	
					break;
				}
				case PivotAlignment.CORNER_1: {
					_pivotOffset.x = halfLenghtHorizontalSide;
					_pivotOffset.y = -halfLengthtVerticalSide;
					break;
				}
				case PivotAlignment.CORNER_2: {
					_pivotOffset.x = halfLenghtHorizontalSide;
					_pivotOffset.y = halfLengthtVerticalSide;
					break;
				}
				case PivotAlignment.CORNER_3: {
					_pivotOffset.x = -halfLenghtHorizontalSide;
					_pivotOffset.y = halfLengthtVerticalSide;
					break;
				}
				default: {
					break;
				}
			}
		}
	}
}