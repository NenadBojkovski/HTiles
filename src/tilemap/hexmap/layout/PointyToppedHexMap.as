package tilemap.hexmap.layout
{
	import flash.geom.Point;
	
	import tilemap.ITile;
	import tilemap.PivotAlignment;
	import tilemap.Tile;
	import tilemap.hexmap.HexMap;
	import tilemap.hexmap.layout.helper.ILayoutHelper;
	import tilemap.hexmap.tile.Hexagon;
	import tilemap.hexmap.tile.PointyToppedHexagon;
	
	public class PointyToppedHexMap extends HexMap
	{
		public function PointyToppedHexMap(radius:Number, helper:ILayoutHelper)
		{
			super(radius, helper);
			_hexagon = new PointyToppedHexagon(radius);
			setCenterOffset(halfHorizontalLenght, halfVerticalLenght);
		}
		
		/*
		* @inheritDoc 
		*/
		override public function getTile(x:Number, y:Number): ITile
		{
			var rotatedPoint: Point = rotatePoint(x,y); 
			var coveringRectTile: ITile = getCoveringRectTile(rotatedPoint.x, rotatedPoint.y);
			var tilePoint: Point = convertToTileCoordinates(rotatedPoint.x, rotatedPoint.y, coveringRectTile);
			var enclosure: int = _hexagon.getEnclosureOf(tilePoint.x, tilePoint.y);
			var ti: Number = coveringRectTile.i;
			var tj: Number = coveringRectTile.j;
			if(enclosure == Hexagon.ENCLOSED_NEARER_TRIANGLE){
				tj = coveringRectTile.j - 1;
				ti = coveringRectTile.i + _helper.getNearerTriangleOffset(tj);
			} else if(enclosure == Hexagon.ENCLOSED_FARTHER_TRIANGLE){
				tj = coveringRectTile.j - 1;
				ti = coveringRectTile.i + _helper.getFartherTriangleOffset(tj);
			}
			return new Tile(ti, tj);
		}
		
		/*
		* @inheritDoc 
		*/
		override public function getTileNeighbors(tile: ITile):Vector.<ITile>
		{
			return neighborOffsetsToTiles(tile, _helper.getNeighborsOffsets(tile.j, false));
		}
		
		/*
		* @inheritDoc 
		*/
		override public function getTileCenter(tile: ITile):Point
		{
		 	var x: Number = tile.i * _hexagon.horizontalLength - _helper.getTileOffset(tile.j) * halfHorizontalLenght - _pivotOffset.x;
			var y: Number = tile.j * _hexagon.coveringRectTileVLength - _pivotOffset.y;
			return inversePointRotation(x, y);
		}
		
		/*
		* Returns rectangular helper tile which covers mostly the hexatile we try to locate, but also covers two neighboring
		* tiles.
		*/
		protected function getCoveringRectTile(x: Number, y: Number): ITile {
			var jSq: int = floor((y + _totalOffest.y) / _hexagon.coveringRectTileVLength);
			var iSq: int = floor((x + _totalOffest.x + _helper.getTileOffset(jSq) * halfHorizontalLenght) / _hexagon.horizontalLength);
			return new Tile(iSq, jSq);
		}
		
		/*
		*  Converts maps coordinates into local, covering rect tile, cooridinates where 0,0 is at top left corner of the covering rect tile
		*/
		protected function convertToTileCoordinates(x: Number, y: Number, coveringSqueredTile: ITile): Point {
			var tilePoint: Point = new Point();
			tilePoint.x = x + _totalOffest.x + _helper.getTileOffset(coveringSqueredTile.j)* halfHorizontalLenght - 
				coveringSqueredTile.i * _hexagon.horizontalLength;
			tilePoint.y = y + _totalOffest.y - coveringSqueredTile.j * _hexagon.coveringRectTileVLength;
			return tilePoint;
		}
		
		override protected function updatePivot(): void { 
			switch(_pivotAlignment)
			{
				case PivotAlignment.CORNER_0: {
					_pivotOffset.x = 0; 
					_pivotOffset.y = -halfVerticalLenght;	
					break;
				}
				case PivotAlignment.CORNER_1: {
					_pivotOffset.x = halfHorizontalLenght; 
					_pivotOffset.y = _hexagon.coveringRectTileVLength - _hexagon.verticalLength;
					break;
				}
				case PivotAlignment.CORNER_2: {
					_pivotOffset.x = halfHorizontalLenght; 
					_pivotOffset.y = _hexagon.verticalLength - _hexagon.coveringRectTileVLength;
					break;
				}
				case PivotAlignment.CORNER_3: {
					_pivotOffset.x = 0; 
					_pivotOffset.y = halfVerticalLenght;
					break;
				}
				case PivotAlignment.CORNER_4: {
					_pivotOffset.x = -halfHorizontalLenght; 
					_pivotOffset.y = _hexagon.verticalLength - _hexagon.coveringRectTileVLength;
					break;
				}
				case PivotAlignment.CORNER_5: {
					_pivotOffset.x = -halfHorizontalLenght; 
					_pivotOffset.y = _hexagon.coveringRectTileVLength - _hexagon.verticalLength;
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