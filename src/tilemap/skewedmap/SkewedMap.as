package tilemap.skewedmap
{
	import flash.geom.Point;
	
	import tilemap.Tile;
	import tilemap.squaremap.SquareMap;
	
	public class SkewedMap extends SquareMap
	{
		private var _skew: Number;
		public function SkewedMap(tileSideLenght: Number, skew: Number, hasDiagonalNeighbors:Boolean = true)
		{
			super(tileSideLenght, hasDiagonalNeighbors);
			_skew = skew;
			
		}
		
		public function set skew(value: Number): void {
			_skew = value;
		}
		
		public function get skew():Number
		{
			return _skew;
		}
		
		// Returns the tile under the map's x,y coodrinates
		override public function getTile(x:Number, y:Number):Tile
		{
			var rotatedPoint: Point = inversePointRotation(x, y); 
			var coveringRectTile: Tile = getCoveringRectTile(rotatedPoint.x, rotatedPoint.y);
			var tilePoint: Point = convertToTileCoordinates(rotatedPoint.x, rotatedPoint.y, coveringRectTile);
			var isInNeighboringTile: Boolean;
			if (_skew > 0) {
				isInNeighboringTile = tilePoint.x <= _tileHorizontalSideLenght * _skew * (1 - tilePoint.y / _tileVerticalSideLenght);
			} else {
				isInNeighboringTile = tilePoint.x >= _tileHorizontalSideLenght * (1 + _skew - _skew*tilePoint.y / _tileVerticalSideLenght);
			}
			var ti: Number = coveringRectTile.i;
			var tj: Number = coveringRectTile.j;
			var neighbour: int = -_skew/abs(_skew);
			if(isInNeighboringTile){
				ti = coveringRectTile.i + neighbour;
			}
			return new Tile(ti, tj);
		}
		
		//Retruns the map coordinates of the central tile point.
		override public function getCenter(tile:Tile):Point
		{
			var y: Number = tile.j * _tileVerticalSideLenght;
			var x: Number = tile.i * _tileHorizontalSideLenght - tile.j * _skew * _tileHorizontalSideLenght;
			return rotatePoint(x, y);
		}
		
		override public function translateToMapCoordinates(screenPoint:Point):Point {
			var rotatedPoint: Point = inversePointRotation(screenPoint.x, screenPoint.y);
			var translatedPoint: Point = new Point();
			translatedPoint.x = rotatedPoint.x  + _skew * rotatedPoint.y * _tileHorizontalSideLenght / _tileVerticalSideLenght;
			translatedPoint.y = rotatedPoint.y;
			return translatedPoint;
		}
		//Returns rectangular helper tile which covers mostly the skew tile we try to locate, but also covers one neighboring
		//tiles.
		protected function getCoveringRectTile(x: Number, y: Number): Tile {
			var jSq: int = floor((y + halfLengthtVerticalSide) / _tileVerticalSideLenght);
			var iSq: int = floor((x + halfLenghtHorizontalSide + _skew * (halfLenghtHorizontalSide + jSq * _tileHorizontalSideLenght)) / _tileHorizontalSideLenght);
			return new Tile(iSq, jSq);
		}
		
		// Converts maps coordinates into local, covering rect tile, cooridinates where 0,0 is at top left corner of the covering rect tile
		protected function convertToTileCoordinates(x: Number, y: Number, coveringSqueredTile: Tile): Point {
			var tilePoint: Point = new Point();
			tilePoint.y = y + halfLengthtVerticalSide - coveringSqueredTile.j * _tileVerticalSideLenght;
			tilePoint.x = x + halfLenghtHorizontalSide + _skew * (halfLenghtHorizontalSide + coveringSqueredTile.j * _tileHorizontalSideLenght) - coveringSqueredTile.i * _tileHorizontalSideLenght;
			return tilePoint;
		}
	}
}