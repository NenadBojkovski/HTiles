package tilemap.hexmap.layout
{
	import flash.geom.Point;
	
	import tilemap.PivotAlignment;
	import tilemap.Tile;
	import tilemap.hexmap.HexMap;
	import tilemap.hexmap.layout.helper.ILayoutHelper;
	import tilemap.hexmap.tile.FlatToppedHexagon;
	import tilemap.hexmap.tile.Hexagon;
	
	public class FlatToppedHexMap extends HexMap
	{
		public function FlatToppedHexMap(radius:Number, helper:ILayoutHelper)
		{
			super(radius, helper);
			_hexagon = new FlatToppedHexagon(radius);
			setCenterOffset(halfHorizontalLenght, halfVerticalLenght);
		}
		
		
		// Returns the hexatile under the map's x,y coodrinates
		override public function getTile(x:Number, y:Number):Tile
		{
			var rotatedPoint: Point = rotatePoint(x,y); 
			var coveringRectTile: Tile = getCoveringRectTile(rotatedPoint.x, rotatedPoint.y);
			var tilePoint: Point = convertToTileCoordinates(rotatedPoint.x, rotatedPoint.y, coveringRectTile);
			var enclosure: int = _hexagon.getEnclosureOf(tilePoint.x, tilePoint.y);
			var ti: Number = coveringRectTile.i;
			var tj: Number = coveringRectTile.j;
			if(enclosure == Hexagon.ENCLOSED_NEARER_TRIANGLE){
				ti = coveringRectTile.i - 1;
				tj = coveringRectTile.j + _helper.getNearerTriangleOffset(ti);
			} else if(enclosure == Hexagon.ENCLOSED_FARTHER_TRIANGLE){
				ti = coveringRectTile.i - 1;
				tj = coveringRectTile.j + _helper.getFartherTriangleOffset(ti);
			}
			return new Tile(ti, tj);
		}
		
		
		override public function getTileNeighbors(tile: Tile):Vector.<Tile>
		{
			return neighborOffsetsToTiles(tile, _helper.getNeighborsOffsets(tile.i, true));
		}
		
		override public function getTileCenter(tile:Tile):Point
		{
			var x: Number = tile.i * _hexagon.coveringRectTileHLength - _pivotOffset.x;
			var y: Number = tile.j * _hexagon.verticalLength - _helper.getTileOffset(tile.i)*halfVerticalLenght - _pivotOffset.y;
			return inversePointRotation(x, y);;
		}
		
		//Returns rectangular helper tile which covers mostly the hexatile we try to locate, but also covers two neighboring
		//tiles.
		protected function getCoveringRectTile(x: Number, y: Number): Tile {
			var iSq: int = floor((x + _totalOffest.x) / _hexagon.coveringRectTileHLength);
			var jSq: int = floor((y + _totalOffest.y + _helper.getTileOffset(iSq)* halfVerticalLenght) / _hexagon.verticalLength);
			return new Tile(iSq, jSq);
		}
		
		// Converts maps coordinates into local, covering rect tile, cooridinates where 0,0 is at top left corner of the covering rect tile
		protected function convertToTileCoordinates(x: Number, y: Number, coveringSqueredTile: Tile): Point {
			var tilePoint: Point = new Point();
			tilePoint.x = x + _totalOffest.x - coveringSqueredTile.i * _hexagon.coveringRectTileHLength;
			tilePoint.y = y + _totalOffest.y + _helper.getTileOffset(coveringSqueredTile.i) * halfVerticalLenght - 
				coveringSqueredTile.j * _hexagon.verticalLength;
			return tilePoint;
		}
		
		override protected function updatePivot(): void { 
			switch(_pivotAlignment)
			{
				case PivotAlignment.CORNER_0: {
					_pivotOffset.x =  -halfHorizontalLenght; 
					_pivotOffset.y = 0;	
					break;
				}
				case PivotAlignment.CORNER_1: {
					_pivotOffset.x = _hexagon.coveringRectTileHLength - _hexagon.horizontalLength; 
					_pivotOffset.y = -halfVerticalLenght;
					break;
				}
				case PivotAlignment.CORNER_2: {
					_pivotOffset.x = _hexagon.horizontalLength - _hexagon.coveringRectTileHLength; 
					_pivotOffset.y = -halfVerticalLenght;
					break;
				}
				case PivotAlignment.CORNER_3: {
					_pivotOffset.x = halfHorizontalLenght; 
					_pivotOffset.y = 0;
					break;
				}
				case PivotAlignment.CORNER_4: {
					_pivotOffset.x = _hexagon.horizontalLength - _hexagon.coveringRectTileHLength; 
					_pivotOffset.y = halfVerticalLenght;
					break;
				}
				case PivotAlignment.CORNER_5: {
					_pivotOffset.x = _hexagon.coveringRectTileHLength - _hexagon.horizontalLength; 
					_pivotOffset.y = halfVerticalLenght;
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