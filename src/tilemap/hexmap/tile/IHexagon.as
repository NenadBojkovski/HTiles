package tilemap.hexmap.tile
{
	public interface IHexagon
	{
		/*
		 * Returns radius of the hexa tile (hexagon) 
		*/
		function get radius(): Number;
		
		/*
		* Returns horizontal lenght of the hexa tile 
		*/
		function get horizontalLength(): Number;
		
		/*
		* Returns vertical lenght of the hexa tile 
		*/
		function get verticalLength(): Number;
		
		/*
		* Returns horizontal lenght of the helping rectangular tile which partly covers(overlaps) the hexa tile.
		*/
		function get coveringRectTileHLength(): Number;
		
		/*
		* Returns vertical lenght of the helping rectangular tile which partly covers(overlaps) the hexa tile.
		*/
		function get coveringRectTileVLength(): Number;
		
		/*
		* Returns vertical scale of the hexa tile
		*/
		function get scaleVertical(): Number;
		
		/*
		* Sets vertical scale of the hexa tile
		*/
		function set scaleVertical(value: Number): void;
		
		/*
		* Returns horizontal scale of the hexa tile
		*/
		function get scaleHorizontal(): Number;
		
		/*
		* Sets horizontal scale of the hexa tile
		*/
		function set scaleHorizontal(value: Number): void
			
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
		function getEnclosureOf(x: Number, y: Number): int;
	}
}