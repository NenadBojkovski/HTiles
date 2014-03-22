package tilemap.isomap
{
	import flash.geom.Point;
	
	import tilemap.PivotAlignment;
	import tilemap.Tile;
	import tilemap.TileMap;
	
	public class IsoMap extends TileMap
	{
		private var _originalTileHeight: Number;
		private var _tileScaledHeight: Number;
		private var _tileScaledWidth: Number;
		private var _hasDiagonalNeighbors: Boolean;
		private var _heightWidthRatio: Number;
		
		public function IsoMap(tileHeight: Number, hasDiagonalNeighbors:Boolean = true)
		{
			_originalTileHeight = _tileScaledHeight = tileHeight;
			_tileScaledWidth = 2 * _originalTileHeight;
			_hasDiagonalNeighbors = hasDiagonalNeighbors;
			_heightWidthRatio = _tileScaledHeight / _tileScaledWidth;
			setCenterOffset(0, halfTileHeight);
		}
		
		public function get tileHeight():Number
		{
			return _originalTileHeight;
		}

		override public function set scaleTileVertical(value:Number):void
		{
			super.scaleTileVertical = value;
			_tileScaledHeight = _originalTileHeight * value;	
			_heightWidthRatio = _tileScaledHeight / _tileScaledWidth;
			setCenterOffset(0, halfTileHeight);
		}
	
		override public function set scaleTileHorizontal(value:Number):void
		{
			super.scaleTileHorizontal = value;
			_tileScaledWidth = 2 * _originalTileHeight * value;
			_heightWidthRatio = _tileScaledHeight / _tileScaledWidth;
			setCenterOffset(0, halfTileHeight);
		}
		
		override public function getTile(x:Number, y:Number):Tile
		{
			var tile: Tile = new Tile();
			var rotatedPoint: Point = rotatePoint(x,y); 
			tile.i = floor(((rotatedPoint.x + _totalOffest.x) / _tileScaledWidth) + ((rotatedPoint.y +  + _totalOffest.y) / _tileScaledHeight));
			tile.j = floor(((rotatedPoint.y + _totalOffest.y) / _tileScaledHeight) - ((rotatedPoint.x + _totalOffest.x) / _tileScaledWidth));
			return tile;
		}
		
		override public function getTileNeighbors(tile:Tile):Vector.<Tile>
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
		
		override public function screenToMapCoordinates(screenPoint: Point):Point
		{
			var rotatedPoint: Point = rotatePoint(screenPoint.x, screenPoint.y); 
			var translatedPoint: Point = new Point();
			translatedPoint.x = rotatedPoint.x * _heightWidthRatio + rotatedPoint.y;
			translatedPoint.y = rotatedPoint.y - rotatedPoint.x * _heightWidthRatio;
			return translatedPoint;
		}
		
		override public function mapToScreenCoordinates(mapPoint:Point): Point {
			var translatedPoint: Point = new Point();
			translatedPoint.x = (mapPoint.x - mapPoint.y) / (2 * _heightWidthRatio);
			translatedPoint.y = (mapPoint.x + mapPoint.y) / 2;
			return inversePointRotation(translatedPoint.x, translatedPoint.y);
		}
		
		override public function getTileCenter(tile:Tile):Point
		{
			var x: Number = (tile.i - tile.j) * halfTileWidth - _pivotOffset.x;
			var y: Number = (tile.i + tile.j) * halfTileHeight - _pivotOffset.y;
			return inversePointRotation(x, y);
		}
		
		private function get halfTileWidth(): Number { 
			return _tileScaledWidth * 0.5;
		}
		
		private function get halfTileHeight(): Number { 
			return _tileScaledHeight * 0.5;
		}
		
		override protected function updatePivot(): void { 
			switch(_pivotAlignment)
			{
				case PivotAlignment.CORNER_0: {
					_pivotOffset.x = 0; 
					_pivotOffset.y = -halfTileHeight;	
					break;
				}
				case PivotAlignment.CORNER_1: {
					_pivotOffset.x = halfTileWidth; 
					_pivotOffset.y = 0;
					break;
				}
				case PivotAlignment.CORNER_2: {
					_pivotOffset.x = 0; 
					_pivotOffset.y = halfTileHeight;
					break;
				}
				case PivotAlignment.CORNER_3: {
					_pivotOffset.x = -halfTileWidth; 
					_pivotOffset.y = 0;
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}