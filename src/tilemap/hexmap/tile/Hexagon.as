package tilemap.hexmap.tile
{

	// ABSTRACT CLASS
	public class Hexagon implements IHexagon
	{
		public static const ENCLOSED_HEXAGON: int = 0;
		public static const ENCLOSED_FARTHER_TRIANGLE: int = 1;
		public static const ENCLOSED_NEARER_TRIANGLE: int = 2;
		
		protected const SQRT_3: Number = Math.sqrt(3);
		protected const abs: Function = Math.abs;
		
		protected var _diagonal:Number;
		protected var _height: Number;
		protected var _side: Number;
		protected var _radius: Number;
		protected var _scaleHorizontal: Number;
		protected var _scaleVertical: Number;
		
		public function Hexagon(radius: Number)
		{
			_radius = radius;
			_diagonal = 2 * radius;
			_side = 1.5 * radius;
			_height = SQRT_3 * radius;
			_scaleHorizontal = _scaleVertical = 1;
		}
		
		/*
		* Returns radius of the hexa tile (hexagon) 
		*/
		public function get radius():Number
		{
			return _radius;
		}
		
		/*
		* Returns horizontal lenght of the hexa tile 
		*/
		public function get horizontalLength():Number
		{
			return 0;
		}
		
		/*
		* Returns vertical lenght of the hexa tile 
		*/
		public function get verticalLength():Number
		{
			return 0;
		}
		
		/*
		* Returns horizontal lenght of the helping rectangular tile which partly covers(overlaps) the hexa tile.
		*/
		public function get coveringRectTileHLength():Number
		{
			return 0;
		}
		
		/*
		* Returns vertical lenght of the helping rectangular tile which partly covers(overlaps) the hexa tile.
		*/
		public function get coveringRectTileVLength():Number
		{
			return 0;
		}
		
		/*
		* Returns vertical scale of the hexa tile
		*/
		public function get scaleVertical():Number
		{
			return _scaleVertical;
		}
		
		/*
		* Sets vertical scale of the hexa tile
		*/
		public function set scaleVertical(value:Number):void
		{
			_scaleVertical = value;
		}
		
		/*
		* Returns horizontal scale of the hexa tile
		*/
		public function get scaleHorizontal():Number
		{
			return _scaleHorizontal;
		}
		
		/*
		* Sets horizontal scale of the hexa tile
		*/
		public function set scaleHorizontal(value:Number):void
		{
			_scaleHorizontal = value;
		}
		
		/*
		* Returns enclosure of a map point related to the covering tile. The covering tile is actually 
		*	consist of three areas: 
		*		- The biggest pentagonal area, which is in the same time belongs to the hexa tile it covers.
		*		- Two tragonal areas (which togather with the pentagonal area compose the covering rectangle),
		*		nearer triangle to the covering tile's coordinate system center (top-left corner) and the farther 
		*		triangle.
		*	
		*	-- --
		*	|/   |\    - Covering rectanglular tile and the hexa tile it covers
		*	|\   |/
		*	-- --
		*	If the point is enclosed in the pentagonal area, it means that it belongs to the hexa tile covered. 
		*	If the point is in one of the two triangular areas, it means it belongs to one of the neighboring 
		*	hexa tiles. To which neighbor it belongs depends on in which of the two tringles it is enclosed, as well
		*	as of the layout of the hexa map.
		*	
		*	x,y are covering tile coordinates, relative to the internal coordinate system of the covering rectangular tile
		*/
		public function getEnclosureOf(x:Number, y:Number):int
		{
			return 0;
		}
		
		protected function get halfHeight(): Number {
			return _height * 0.5;
		}	
		
		protected function get halfDiagonal(): Number {
			return _diagonal * 0.5;
		}	
		
		protected function get triangleHeight(): Number {
			return _diagonal - _side;
		}
	}
}