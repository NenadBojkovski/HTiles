package tilemap
{
	import flash.geom.Point;

	public interface ITileMap
	{
		/*
		* Returns the tile under (x,y) map point.  
		*/
		function getTile(x: Number, y: Number): ITile;
		
		/*
		* Returns the neighboring tiles of the tile
		*/
		function getTileNeighbors(tile:ITile): Vector.<ITile>;
		
		/*
		* Returns the center of the tile as a map point
		*/
		function getTileCenter(tile: ITile): Point;
				
		/*
		* Converts screen coordinates into map coordinates.
		*
		* IMPORTANT NOTE: If the map is not added directly to the Stage, but contained in certain container 
		* e.g. Sprite or Movieclip, the global(Stage) screen point should first be translated to local container's
		* point and than passed to this method.
		*
		*/
		function screenToMapCoordinates(screenPoint: Point): Point;
		
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
		function mapToScreenCoordinates(mapPoint: Point): Point;
		
		/*
		* Returns tile's vertical scale.
		*/
		function get scaleTileVertical(): Number;
		
		/*
		* Extends map's tile vertically, with that map is extended too.
		* 
		* It is important to note that with this method actualy the vertical size of the tile is changed, so 
		* usage of this method has no influence on the performance. It is the same as the vertical size is set
		* manually.
		*/
		function set scaleTileVertical(value: Number): void;
		
		/*
		* Returns tile's horizontal scale.
		*/
		function get scaleTileHorizontal(): Number;
		
		/*
		* Extends map's tile horizontaly, with that map is extended too.
		* 
		* It is important to note that with this method actualy the horizontal size of the tile is changed, so 
		* usage of this method has no influence on the performance. It is the same as the horizontal size is set
		* manually.
		*/
		function set scaleTileHorizontal(value: Number): void;
		
		/*
		* Rotates the map for a given angle in degrees.
		*/
		function set rotation(value: Number): void;
		
		/*
		* Returns the rotation of the map in degrees.
		*/
		function get rotation(): Number;
		
		/*
		* Returns the pivot of the tile as a map point
		*/
		function getTilePivot(tile: ITile): Point;	
		
		/*
		* Sets a tile's pivot point to one of the predefined ones. 
		* 
		* @see PivotAlignment
		*/
		function set pivotAlignment(value: String): void;
		
		/*
		 * Returns current tile's pivot point alignment. 
		*/
		function get pivotAlignment(): String;
		
		/*
		* Set's custom pivot point of a tile. 
		*
		* Similar to flash registration point concept, there are several predefined pivot points e.g. center, 
		* four corner pivots for squared tiles and six for hexatiles. However with this method it is possible
		* custom pivot point for a tile to be defined.
		*/
		function setCustomPivot(x: Number, y: Number): void;
	}
}