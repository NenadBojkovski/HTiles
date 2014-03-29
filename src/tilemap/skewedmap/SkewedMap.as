package tilemap.skewedmap
{
	import flash.geom.Point;
	
	import tilemap.ITile;
	import tilemap.PivotAlignment;
	import tilemap.Tile;
	import tilemap.squaremap.SquareMap;
	
	public class SkewedMap extends SquareMap
	{
		private var _skew: Number;
		public function SkewedMap(tileSideLenght: Number, skew: Number, hasDiagonalNeighbors:Boolean = true)
		{
			_skew = skew;
			super(tileSideLenght, hasDiagonalNeighbors);
		}
		
		/*
		 * Sets skew of a tile. Only horizontal skew is possible. 
		*/
		public function set skew(value: Number): void {
			_skew = value;
		}
		
		/*
		 * Returns the skew of a tile. 
		*/
		public function get skew():Number
		{
			return _skew;
		}
		
		/*
		* @inheritDoc 
		*/
		override public function getTile(x:Number, y:Number): ITile
		{
			var rotatedPoint: Point = rotatePoint(x, y); 
			var coveringRectTile: ITile = getCoveringRectTile(rotatedPoint.x, rotatedPoint.y);
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
		
		/*
		* @inheritDoc 
		*/
		override public function getTileCenter(tile: ITile):Point
		{
			var y: Number = tile.j * _tileVerticalSideLenght - _pivotOffset.y;
			var x: Number = tile.i * _tileHorizontalSideLenght - tile.j * _skew * _tileHorizontalSideLenght - _pivotOffset.x;
			return inversePointRotation(x, y);
		}
		
		/*
		* @inheritDoc 
		*/
		override public function screenToMapCoordinates(screenPoint: Point): Point {
			var rotatedPoint: Point = rotatePoint(screenPoint.x, screenPoint.y);
			var translatedPoint: Point = new Point();
			translatedPoint.x = rotatedPoint.x  + _skew * rotatedPoint.y * _tileHorizontalSideLenght / _tileVerticalSideLenght;
			translatedPoint.y = rotatedPoint.y;
			return translatedPoint;
		}
		
		/*
		* @inheritDoc 
		*/
		override public function mapToScreenCoordinates(mapPoint: Point): Point {
			var translatedPoint: Point = new Point();
			translatedPoint.x = mapPoint.x - _skew * mapPoint.y * _tileHorizontalSideLenght / _tileVerticalSideLenght;
			translatedPoint.y = mapPoint.y;
			return inversePointRotation(translatedPoint.x, translatedPoint.y);
		}
		
		/*
		* Returns rectangular helper tile which covers mostly the skew tile that should be located, 
		* but also covers one neighboring tile.
		*/
		protected function getCoveringRectTile(x: Number, y: Number): ITile {
			var jSq: int = floor((y + _totalOffest.y) / _tileVerticalSideLenght);
			var iSq: int = floor((x + _totalOffest.x + _skew * jSq * _tileHorizontalSideLenght) / _tileHorizontalSideLenght);
			return new Tile(iSq, jSq);
		}
		
		/*
		* Converts maps coordinates into local, covering rect tile, cooridinates where 0,0 is at top left corner of 
		* the covering rect tile
		*/
		protected function convertToTileCoordinates(x: Number, y: Number, coveringSqueredTile: ITile): Point {
			var tilePoint: Point = new Point();
			tilePoint.y = y + _totalOffest.y - coveringSqueredTile.j * _tileVerticalSideLenght;
			tilePoint.x = x + _totalOffest.x + _skew * coveringSqueredTile.j * _tileHorizontalSideLenght - coveringSqueredTile.i * _tileHorizontalSideLenght;
			return tilePoint;
		}
		
		override protected function get centerOffsetX(): Number {
			return (1 + _skew) * halfLenghtHorizontalSide;
		}
		
		override protected function updatePivot(): void { 
			switch(_pivotAlignment)
			{
				case PivotAlignment.CORNER_0: {
					_pivotOffset.x = -(1 - _skew) * halfLenghtHorizontalSide;
					_pivotOffset.y = -halfLengthtVerticalSide;	
					break;
				}
				case PivotAlignment.CORNER_1: {
					_pivotOffset.x = centerOffsetX;
					_pivotOffset.y = -halfLengthtVerticalSide;
					break;
				}
				case PivotAlignment.CORNER_2: {
					_pivotOffset.x = (1 - _skew) * halfLenghtHorizontalSide;
					_pivotOffset.y = halfLengthtVerticalSide;
					break;
				}
				case PivotAlignment.CORNER_3: {
					_pivotOffset.x = -centerOffsetX;
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