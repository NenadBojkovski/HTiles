package tilemap.hexmap.tile
{
	public class PointyToppedHexagon extends Hexagon
	{
		public function PointyToppedHexagon(radius:Number)
		{
			super(radius);
		}
		
		override public function get horizontalLength():Number
		{
			return _height;
		}
		
		override public function get verticalLength():Number
		{
			return _diagonal;
		}
		
		override public function get coveringRectTileHLength():Number
		{
			return _height;
		}
		
		override public function get coveringRectTileVLength():Number
		{
			return _side;
		}
		
		override public function set scaleVertical(value:Number):void
		{
			super.scaleVertical = value;
			_diagonal = 2 * _radius * value;
			_side = 1.5 * _radius * value;
		}
		
		override public function set scaleHorizontal(value:Number):void
		{
			super.scaleHorizontal = value;
			_height = SQRT_3 * _radius * value;
		}
		
		// CAUTION - x,y are covering tile coordinates, relative to the internal coordinate system of the covering rectangular tile
		override public function getEnclosureOf(x:Number, y:Number):int
		{
			var isInHexagon: Boolean = y >= triangleHeight * abs(1 - x / halfHeight);
			if (isInHexagon) {
				return Hexagon.ENCLOSED_HEXAGON;
			} else if (x > halfHeight) {
				return Hexagon.ENCLOSED_FARTHER_TRIANGLE;
			}
			return Hexagon.ENCLOSED_NEARER_TRIANGLE;
		}
	}
}