package tilemap.hexmap.tile
{
	public interface IHexagon
	{
		function get radius(): Number;
		function get horizontalLength(): Number;
		function get verticalLength(): Number;
		function get coveringRectTileHLength(): Number;
		function get coveringRectTileVLength(): Number;
		function get scaleVertical(): Number;
		function set scaleVertical(value: Number): void;
		function get scaleHorizontal(): Number;
		function set scaleHorizontal(value: Number): void
		function getEnclosureOf(x: Number, y: Number): int;
	}
}