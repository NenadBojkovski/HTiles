package tilemap.hexmap.layout.helper
{
	import flash.geom.Point;

	public class NeighborOffsetsKeeper
	{
		public static const ODD_ROW_OFFSET: Vector.<Point> = Vector.<Point>([new Point(-1,0), new Point(0,-1), new Point(1,-1),
			new Point(1,0), new Point(1,1), new Point(0, 1)]);
		public static const ODD_COLUMN_OFFSET: Vector.<Point> = Vector.<Point>([new Point(-1,0), new Point(0,-1), new Point(1,0),
			new Point(1,1), new Point(0, 1), new Point(-1,1)]);
		public static const EVEN_ROW_OFFSET: Vector.<Point> = Vector.<Point>([new Point(-1,0), new Point(-1,-1), new Point(0,-1),
			new Point(1,0), new Point(0, 1), new Point(-1,1)]);
		public static const EVEN_COLUMN_OFFSET: Vector.<Point> = Vector.<Point>([new Point(-1,0), new Point(-1,-1), new Point(0,-1),
			new Point(1,-1), new Point(1,0), new Point(0, 1)]);
		public static const DIAMOND_UP: Vector.<Point> = Vector.<Point>([new Point(-1,0), new Point(-1,-1), new Point(0,-1),
			new Point(1,0), new Point(1,1), new Point(0, 1)]);
		public static const DIAMOND_DOWN: Vector.<Point> = Vector.<Point>([new Point(-1,1), new Point(-1,0), new Point(0,-1), 
			new Point(1,-1), new Point(1,0), new Point(0, 1)]);
		public static const AXIAL: Vector.<Point> = Vector.<Point>([new Point(-1,0), new Point(0,-1), new Point(1,-1),  
			new Point(1, 0), new Point(0,1), new Point(-1,1)]);
	}
}