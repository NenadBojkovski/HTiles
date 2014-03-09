package tilemap.isomap
{
	import flash.geom.Point;
	
	import tilemap.Tile;
	import tilemap.TileMap;
	
	public class IsoMap extends TileMap
	{
		private var _originalTileHeight: Number;
		private var _tileScaledHeight: Number;
		private var _tileScaledWidth: Number;
		private var _hasDiagonalNeighbors: Boolean;
		
		public function IsoMap(tileHeight: Number, hasDiagonalNeighbors:Boolean = true)
		{
			_originalTileHeight = _tileScaledHeight = tileHeight;
			_tileScaledWidth = 2 * _originalTileHeight;
			_hasDiagonalNeighbors = hasDiagonalNeighbors;
		}
		
		public function get tileHeight():Number
		{
			return _originalTileHeight;
		}

		override public function set scaleTileVertical(value:Number):void
		{
			super.scaleTileVertical = value;
			_tileScaledHeight = _originalTileHeight * value;			
		}
	
		override public function set scaleTileHorizontal(value:Number):void
		{
			super.scaleTileHorizontal = value;
			_tileScaledWidth = 2 * _originalTileHeight * value;
		}
		
		override public function getTile(x:Number, y:Number):Tile
		{
			var tile: Tile = new Tile();
			var rotatedPoint: Point = inversePointRotation(x,y); 
			tile.i = floor((rotatedPoint.x / _tileScaledWidth) + ((rotatedPoint.y + halfTileHeight) / _tileScaledHeight));
			tile.j = floor(((rotatedPoint.y + halfTileHeight) / _tileScaledHeight) - (rotatedPoint.x / _tileScaledWidth));
			return tile;
		}
		
		override public function getNeighbors(tile:Tile):Vector.<Tile>
		{
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
		
		override public function getCenter(tile:Tile):Point
		{
			var x: Number = (tile.i - tile.j) * halfTileWidth;
			var y: Number = (tile.i + tile.j) * halfTileHeight;
			return rotatePoint(x, y);
		}
		
		private function get halfTileWidth(): Number { 
			return _tileScaledWidth * 0.5;
		}
		
		private function get halfTileHeight(): Number { 
			return _tileScaledHeight * 0.5;
		}
	}
}