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
		
		protected var _pivotAlignment: String; 
		protected var _pivotOffset: Point;
		protected var _totalOffest: Point; 
		
		private var _centerOffset: Point;
		
		
		public function TileMap()
		{
			_scaleTileHorizontal = _scaleTileVertical = 1;
			rotation = 0;
			_centerOffset = new Point();
			_pivotOffset = new Point();
			_totalOffest = new Point();
			_pivotAlignment = PivotAlignment.CENTER;
		}
		
		public function getTile(x:Number, y:Number):Tile
		{
			return null;
		}
		
		public function getTileNeighbors(tile:Tile):Vector.<Tile>
		{
			return null;
		}
		
		public function getTileCenter(tile:Tile):Point
		{
			return null;
		}
		
		public function screenToMapCoordinates(screenPoint: Point):Point
		{
			return rotatePoint(screenPoint.x, screenPoint.y);
		}
		
		public function mapToScreenCoordinates(mapPoint: Point):Point
		{
			return inversePointRotation(mapPoint.x, mapPoint.y);
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
		
		protected function updatePivot(): void {
			
		}
		
		public function get pivotX(): Number {
			return inversePointRotation(_pivotOffset.x, _pivotOffset.y).x;
		}
		
		public function get pivotY(): Number {
			return inversePointRotation(_pivotOffset.x, _pivotOffset.y).y;
		}
		
		public function set pivotAlignment(value: String): void {
			if (_pivotAlignment != value) {
				_pivotAlignment = value;
				updateTotalOffest();
			}
		}
		
		public function get pivotAlignment(): String {
			return _pivotAlignment;
		}
		
		public function setCustomPivot(x: Number, y: Number): void {
			_pivotAlignment = PivotAlignment.CUSTOM;
			_pivotOffset.x = x;
			_pivotOffset.y = y;
			updateTotalOffest();
		}
		
		protected function setCenterOffset(x: Number, y: Number): void {
			_centerOffset.x = x;
			_centerOffset.y = y;
			updateTotalOffest();
		}
		
		protected function updateTotalOffest(): void{
			updatePivot();
			_totalOffest.x = _centerOffset.x + _pivotOffset.x;
			_totalOffest.y = _centerOffset.y + _pivotOffset.y;
		}
		
		protected function rotatePoint(x: Number, y: Number): Point{
			var xRot: Number = x * _cosRotation - y * _sinRotation;
			var yRot: Number = y * _cosRotation + x * _sinRotation;
			return new Point(xRot, yRot);
		}
		
		protected function inversePointRotation(x: Number, y: Number): Point{
			var xInverseRot: Number = x * _cosRotation + y * _sinRotation;
			var yInverseRot: Number = y * _cosRotation - x * _sinRotation;
			return new Point(xInverseRot, yInverseRot);
		}
	}
}