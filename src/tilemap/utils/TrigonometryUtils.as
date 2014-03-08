package tilemap.utils
{
	public class TrigonometryUtils
	{
		public static function degreesToRadians(angleDegrees: Number): Number {
			return angleDegrees * Math.PI / 180;
		}
		
		public static function radiansToDegrees(angleRadians: Number): Number {
			return angleRadians * 180 / Math.PI;
		}
	}
}