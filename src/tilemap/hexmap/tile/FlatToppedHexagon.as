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
		
		/*
		* @inheritDoc 
		*/
		override public function get horizontalLength():Number
		{
			return _diagonal;
		}
		
		/*
		* @inheritDoc 
		*/
		override public function get verticalLength():Number
		{
			return _height;
		}
		
		/*
		* @inheritDoc 
		*/
		override public function get coveringRectTileHLength():Number
		{
			return _side;
		}
		
		/*
		* @inheritDoc 
		*/
		override public function get coveringRectTileVLength():Number
		{
			return _height;
		}
		
		/*
		* @inheritDoc 
		*/
		override public function set scaleVertical(value:Number):void
		{
			super.scaleVertical = value;
			_height = SQRT_3 * _radius * value;
		}
			
		/*
		* @inheritDoc 
		*/
		override public function set scaleHorizontal(value:Number):void
		{
			super.scaleHorizontal = value;
			_diagonal = 2 * _radius * value;
			_side = 1.5 * _radius * value;
		}
		
		/*
		* @inheritDoc 
		*/
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