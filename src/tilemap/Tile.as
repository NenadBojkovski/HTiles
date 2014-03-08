package tilemap
{
	public class Tile
	{
		private var _i: int;
		private var _j: int;
		public function Tile(i: int = 0, j: int = 0)
		{
			_i = i;
			_j = j;
		}

		public function get j():int
		{
			return _j;
		}

		public function set j(value:int):void
		{
			_j = value;
		}

		public function get i():int
		{
			return _i;
		}

		public function set i(value:int):void
		{
			_i = value;
		}
		
		public function toString(): String {
			return "Tile i = " + i + " j = " + j;
		}

	}
}