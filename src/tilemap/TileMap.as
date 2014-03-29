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
		
		/*
		* ABSTRACT METHOD
		* Returns the tile under (x,y) map point.  
		*/
		public function getTile(x:Number, y:Number): ITile
		{
			return null;
		}
		
		/*
		* ABSTRACT METHOD
		* Returns the neighboring tiles of the tile
		*/
		public function getTileNeighbors(tile:ITile):Vector.<ITile>
		{
			return null;
		}
		
		/*
		* ABSTRACT METHOD
		* Returns the center of the tile as a map point
		*/
		public function getTileCenter(tile:ITile):Point
		{
			return null;
		}
		
		/*
		* Converts screen coordinates into map coordinates.
		*
		* IMPORTANT NOTE: If the map is not added directly to the Stage, but contained in certain container 
		* e.g. Sprite or Movieclip, the global(Stage) screen point should first be translated to local container's
		* point and than passed to this method.
		*
		*/
		public function screenToMapCoordinates(screenPoint: Point): Point
		{
			return rotatePoint(screenPoint.x, screenPoint.y);
		}
		
		/*
		* Converts map coordinates into screen coordinates.
		*
		* IMPORTANT NOTE: If the map is not added directly to the Stage, but contained in certain container 
		* e.g. Sprite or Movieclip, the screen point obtained by this method will be relative to the container's
		* coordinate system. If global(Stage) point is needed, the obtained point needs to be translated to the 
		* Stage's coordinate system.
		*
		* @see flash.display.DisplayObject localToGlobal. 
		*/
		public function mapToScreenCoordinates(mapPoint: Point): Point
		{
			return inversePointRotation(mapPoint.x, mapPoint.y);
		}
		
		/*
		* Returns tile's vertical scale.
		*/
		public function get scaleTileVertical():Number
		{
			return _scaleTileVertical;
		}
		
		/*
		* Extends map's tile vertically, with that map is extended too.
		* 
		* It is important to note that with this method actualy the vertical size of the tile is changed, so 
		* usage of this method has no influence on the performance. It is the same as the vertical size is set
		* manually.
		*/
		public function set scaleTileVertical(value:Number): void
		{
			_scaleTileVertical = value;
		}
		
		/*
		* Returns tile's horizontal scale.
		*/
		public function get scaleTileHorizontal(): Number
		{
			return _scaleTileHorizontal;
		}
		
		/*
		* Extends map's tile horizontaly, with that map is extended too.
		* 
		* It is important to note that with this method actualy the horizontal size of the tile is changed, so 
		* usage of this method has no influence on the performance. It is the same as the horizontal size is set
		* manually.
		*/
		public function set scaleTileHorizontal(value:Number): void
		{
			_scaleTileHorizontal = value;
		}
		
		/*
		* Rotates the map for a given angle in degrees.
		*/
		public function set rotation(value: Number): void {
			_rotationDegrees = value;
			_rotationRadians = TrigonometryUtils.degreesToRadians(value);
			_cosRotation = cos(_rotationRadians);
			_sinRotation = sin(_rotationRadians);
		}
		
		/*
		* Returns the rotation of the map in degrees.
		*/
		public function get rotation(): Number {
			return _rotationDegrees;
		}
		
		protected function updatePivot(): void {
			
		}
		
		/*
		* Returns the pivot of the tile as a map point
		*/
		public function getTilePivot(tile: ITile): Point {
			var pivotPoint: Point = getTileCenter(tile);
			var pivotOffsetRotated: Point = inversePointRotation(_pivotOffset.x, _pivotOffset.y); 
			pivotPoint.x += pivotOffsetRotated.x;
			pivotPoint.y += pivotOffsetRotated.y;
			return pivotPoint;
		}
		
		/*
		* Sets a tile's pivot point to one of the predefined ones. 
		* 
		* @see PivotAlignment
		*/
		public function set pivotAlignment(value: String): void {
			if (_pivotAlignment != value) {
				_pivotAlignment = value;
				updateTotalOffest();
			}
		}
		
		/*
		* Returns current tile's pivot point alignment. 
		*/
		public function get pivotAlignment(): String {
			return _pivotAlignment;
		}
		
		/*
		* Set's custom pivot point of a tile. 
		*
		* Similar to flash registration point concept, there are several predefined pivot points e.g. center, 
		* four corner pivots for squared tiles and six for hexatiles. However with this method it is possible
		* custom pivot point for a tile to be defined.
		*/
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