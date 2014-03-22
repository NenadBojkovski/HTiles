package tilemap
{
	public class PivotAlignment
	{
		public static const CENTER: String = "center";
		public static const CUSTOM: String = "custom";
		
		//top_left(SquaredMap/SkewedMap), top(IsoMap), left spike(tringle) (FlatToppedHexamap), 
		//top spike(triangle) (PointyToppedHexaMap)
		public static const CORNER_0: String = "corner_0"; 
		// Next CW (Clockwise) corner and so on ...
		public static const CORNER_1: String = "corner_1"; 
		public static const CORNER_2: String = "corner_2"; 
		public static const CORNER_3: String = "corner_3";
		//valid only for HexaMap. No effect on Squared/Skewed/IsoMapt 
		public static const CORNER_4: String = "corner_4"; 
		public static const CORNER_5: String = "corner_5"; 
		
	}
}