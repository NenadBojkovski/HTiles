package tilemap.hexmap.layout
{
	import flash.geom.Point;
	
	import tilemap.Tile;
	import tilemap.hexmap.layout.helper.ILayoutHelper;
	import tilemap.hexmap.tile.Hexagon;
	import tilemap.hexmap.tile.PointyToppedHexagon;
	
	public class PointyToppedHexMap extends HexMap
	{
		public function PointyToppedHexMap(radius:Number, helper:ILayoutHelper)
		{
			super(radius, helper);
			_hexagon = new PointyToppedHexagon(radius);
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
				tj = coveringRectTile.j - 1;
				ti = coveringRectTile.i + _helper.getNearerTriangleOffset(tj);
			} else if(enclosure == Hexagon.ENCLOSED_FARTHER_TRIANGLE){
				tj = coveringRectTile.j - 1;
				ti = coveringRectTile.i + _helper.getFartherTriangleOffset(tj);
			}
			return new Tile(ti, tj);
		}
		
		override public function getNeighbors(tile: Tile):Vector.<Tile>
		{
			return neighborOffsetsToTiles(tile, _helper.getNeighborsOffsets(tile.j, false));
		}
		
		//Retruns the map coordinates of the central tile point.
		override public function getCenter(tile:Tile):Point
		{
		 	var x: Number = tile.i * _hexagon.horizontalLength - _helper.getTileOffset(tile.j) * halfHorizontalLenght;
			var y: Number = tile.j * _hexagon.coveringRectTileVLength;
			return rotatePoint(x, y);
		}
		
		//Returns rectangular helper tile which covers mostly the hexatile we try to locate, but also covers two neighboring
		//tiles.
		protected function getCoveringRectTile(x: Number, y: Number): Tile {
			var jSq: int = floor((y + halfVerticalLenght) / _hexagon.coveringRectTileVLength);
			var iSq: int = floor((x + (1 + _helper.getTileOffset(jSq)) * halfHorizontalLenght) / _hexagon.horizontalLength);
			return new Tile(iSq, jSq);
		}
		
		// Converts maps coordinates into local, covering rect tile, cooridinates where 0,0 is at top left corner of the covering rect tile
		protected function convertToTileCoordinates(x: Number, y: Number, coveringSqueredTile: Tile): Point {
			var tilePoint: Point = new Point();
			tilePoint.x = x + (1 + _helper.getTileOffset(coveringSqueredTile.j))* halfHorizontalLenght - 
				coveringSqueredTile.i * _hexagon.horizontalLength;
			tilePoint.y = y + halfVerticalLenght - coveringSqueredTile.j * _hexagon.coveringRectTileVLength;
			return tilePoint;
		}
	}
}