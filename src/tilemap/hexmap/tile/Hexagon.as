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
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function get horizontalLength():Number
		{
			return 0;
		}
		
		public function get verticalLength():Number
		{
			return 0;
		}
		
		public function get coveringRectTileHLength():Number
		{
			return 0;
		}
		
		public function get coveringRectTileVLength():Number
		{
			return 0;
		}
		
		public function get scaleVertical():Number
		{
			return _scaleVertical;
		}
		
		public function set scaleVertical(value:Number):void
		{
			_scaleVertical = value;
		}
		
		public function get scaleHorizontal():Number
		{
			return _scaleHorizontal;
		}
		
		public function set scaleHorizontal(value:Number):void
		{
			_scaleHorizontal = value;
		}
		
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