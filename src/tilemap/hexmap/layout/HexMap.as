package tilemap.hexmap.layout
{
	import flash.geom.Point;
	
	import tilemap.Tile;
	import tilemap.TileMap;
	import tilemap.hexmap.layout.helper.AxialLayoutHelper;
	import tilemap.hexmap.layout.helper.ILayoutHelper;
	import tilemap.hexmap.tile.FlatToppedHexagon;
	import tilemap.hexmap.tile.Hexagon;

	/*
	ABSTRACT CLASS
	 */
	public class HexMap extends TileMap
	{
		public static const FLAT_TOPPED: int = 0;
		public static const POINTY_TOPPED: int = 1;
		
		protected var _hexagon: Hexagon;
		protected var _helper: ILayoutHelper;
		
		public function HexMap(radius: Number, helper: ILayoutHelper)
		{
			_helper = helper;
		}
			
		public function get isAxial(): Boolean {
			return _helper is AxialLayoutHelper;
		}
		override public function get scaleTileVertical():Number
		{
			return _hexagon.scaleVertical;
		}
		
		override public function set scaleTileVertical(value:Number):void
		{
			_hexagon.scaleVertical = value;
		}
		
		override public function get scaleTileHorizontal():Number
		{
			return _hexagon.scaleHorizontal;
		}
		
		override public function set scaleTileHorizontal(value:Number):void
		{
			_hexagon.scaleHorizontal = value;
		}
		
		public function get hexagonRadius():Number
		{
			return _hexagon.radius;
		}
		
		protected function neighborOffsetsToTiles(tile: Tile, neighborOffsets: Vector.<Point>):Vector.<Tile>
		{
			var neighbors: Vector.<Tile> = new Vector.<Tile>();
			var neighborOffset: Point;
			var neighborTile: Tile;
			var neigborOffsetsLenght: int = neighborOffsets.length;
			for (var i: int = 0; i < neigborOffsetsLenght; ++i) {
				neighborOffset = neighborOffsets[i];
				neighborTile = new Tile(tile.i + neighborOffset.x, tile.j + neighborOffset.y);
				neighbors.push(neighborTile);
			}
			return neighbors;
		}
		
		protected function get halfHorizontalLenght(): Number {
			return 0.5 * _hexagon.horizontalLength;
		}
		
		protected function get halfVerticalLenght(): Number {
			return 0.5 * _hexagon.verticalLength;	
		}
	}
}