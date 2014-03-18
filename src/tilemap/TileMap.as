package tilemap
{
	import flash.geom.Point;
	import tilemap.utils.TrigonometryUtils;
	
	/*
	ABSTRACT CLASS
	*/
	public class TileMap implements ITileMap
	{
		public static const SQUARED: int = 0;
		public static const SKEWED: int = 1;
		public static const ISO: int = 2;
		public static const HEXA: int = 3;
		
		protected const floor: Function = Math.floor;
		protected const abs: Function = Math.abs;
		protected const sqrt:Function = Math.sqrt;
		protected const pow:Function = Math.pow;
		protected const sin:Function = Math.sin;
		protected const cos:Function = Math.cos;
		protected const atan:Function = Math.atan;
		
		protected var _scaleTileHorizontal: Number; 
		protected var _scaleTileVertical: Number; 
		protected var _rotationDegrees: Number; 
		protected var _rotationRadians: Number; 
		protected var _cosRotation: Number;
		protected var _sinRotation: Number;
		
		public function TileMap()
		{
			_scaleTileHorizontal = _scaleTileVertical = 1;
			rotation = 0;
		}
		
		public function getTile(x:Number, y:Number):Tile
		{
			return null;
		}
		
		public function getNeighbors(tile:Tile):Vector.<Tile>
		{
			return null;
		}
		
		public function getCenter(tile:Tile):Point
		{
			return null;
		}
		
		public function translateToMapCoordinates(screenPoint: Point):Point
		{
			return inversePointRotation(screenPoint.x, screenPoint.y);
		}
		
		public function get scaleTileVertical():Number
		{
			return _scaleTileVertical;
		}
		
		public function set scaleTileVertical(value:Number):void
		{
			_scaleTileVertical = value;
		}
		
		public function get scaleTileHorizontal():Number
		{
			return _scaleTileHorizontal;
		}
		
		public function set scaleTileHorizontal(value:Number):void
		{
			_scaleTileHorizontal = value;
		}
		
		public function set rotation(value: Number): void {
			_rotationDegrees = value;
			_rotationRadians = TrigonometryUtils.degreesToRadians(value);
			_cosRotation = cos(_rotationRadians);
			_sinRotation = sin(_rotationRadians);
		}
		
		public function get rotation(): Number {
			return _rotationDegrees;
		}
		
		protected function inversePointRotation(x: Number, y: Number): Point{
			var xRot: Number = x * _cosRotation - y * _sinRotation;
			var yRot: Number = y * _cosRotation + x * _sinRotation;
			return new Point(xRot, yRot);
		}
		
		protected function rotatePoint(x: Number, y: Number): Point{
			var xInverseRot: Number = x * _cosRotation + y * _sinRotation;
			var yInverseRot: Number = y * _cosRotation - x * _sinRotation;
			return new Point(xInverseRot, yInverseRot);
		}
	}
}