package tilemap.hexmap.tile
{
	import flashx.textLayout.elements.SubParagraphGroupElement;

	public class FlatToppedHexagon extends Hexagon
	{
		
		
		public function FlatToppedHexagon(radius:Number)
		{
			super(radius);
			_diagonal = 2 * radius;
			_side = 1.5 * radius;
			_height = SQRT_3 * radius;
		}
		
		override public function get horizontalLength():Number
		{
			return _diagonal;
		}
		
		override public function get verticalLength():Number
		{
			return _height;
		}
		
		override public function get coveringRectTileHLength():Number
		{
			return _side;
		}
		
		override public function get coveringRectTileVLength():Number
		{
			return _height;
		}
				
		override public function set scaleVertical(value:Number):void
		{
			super.scaleVertical = value;
			_height = SQRT_3 * _radius * value;
		}
			
		override public function set scaleHorizontal(value:Number):void
		{
			super.scaleHorizontal = value;
			_diagonal = 2 * _radius * value;
			_side = 1.5 * _radius * value;
		}
		
		// CAUTION - x,y are covering tile coordinates, relative to the internal coordinate system of the covering rectangular tile
		override public function getEnclosureOf(x:Number, y:Number):int
		{
			var isInHexagon: Boolean = x >= triangleHeight * abs(1 - y / halfHeight);
			if (isInHexagon) {
				return Hexagon.ENCLOSED_HEXAGON;
			} else if (y > halfHeight) {
				return Hexagon.ENCLOSED_FARTHER_TRIANGLE;
			}
			return Hexagon.ENCLOSED_NEARER_TRIANGLE;
		}
		
	}
}