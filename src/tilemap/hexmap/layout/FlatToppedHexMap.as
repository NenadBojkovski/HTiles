package tilemap.hexmap.layout
{
	import flash.geom.Point;
	
	import tilemap.Tile;
	import tilemap.hexmap.layout.helper.ILayoutHelper;
	import tilemap.hexmap.tile.FlatToppedHexagon;
	import tilemap.hexmap.tile.Hexagon;
	
	public class FlatToppedHexMap extends HexMap
	{
		public function FlatToppedHexMap(radius:Number, helper:ILayoutHelper)
		{
			super(radius, helper);
			_hexagon = new FlatToppedHexagon(radius);
		}
		
		
		// Returns the hexatile under the map's x,y coodrinates
		override public function getTile(x:Number, y:Number):Tile
		{
			var rotatedPoint: Point = inversePointRotation(x,y); 
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
		
		
		override public function getNeighbors(tile: Tile):Vector.<Tile>
		{
			return neighborOffsetsToTiles(tile, _helper.getNeighborsOffsets(tile.i, true));
		}
		
		override public function getCenter(tile:Tile):Point
		{
			var x: Number = tile.i * _hexagon.coveringRectTileHLength;
			var y: Number = tile.j * _hexagon.verticalLength - _helper.getTileOffset(tile.i)*halfVerticalLenght;
			return rotatePoint(x, y);;
		}
		
		//Returns rectangular helper tile which covers mostly the hexatile we try to locate, but also covers two neighboring
		//tiles.
		protected function getCoveringRectTile(x: Number, y: Number): Tile {
			var iSq: int = floor((x + halfHorizontalLenght) / _hexagon.coveringRectTileHLength);
			var jSq: int = floor((y + (1 + _helper.getTileOffset(iSq))* halfVerticalLenght) / _hexagon.verticalLength);
			return new Tile(iSq, jSq);
		}
		
		// Converts maps coordinates into local, covering rect tile, cooridinates where 0,0 is at top left corner of the covering rect tile
		protected function convertToTileCoordinates(x: Number, y: Number, coveringSqueredTile: Tile): Point {
			var tilePoint: Point = new Point();
			tilePoint.x = x + halfHorizontalLenght - coveringSqueredTile.i * _hexagon.coveringRectTileHLength;
			tilePoint.y = y + (1 + _helper.getTileOffset(coveringSqueredTile.i))* halfVerticalLenght - 
				coveringSqueredTile.j * _hexagon.verticalLength;
			return tilePoint;
		}
	}
}