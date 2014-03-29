package tilemap
{
	public class Tile implements ITile
	{
		private var _i: int;
		private var _j: int;
		public function Tile(i: int = 0, j: int = 0)
		{
			_i = i;
			_j = j;
		}

		/*
		* Returns tile's j(row) coordinate 
		*/
		public function get j():int
		{
			return _j;
		}

		/*
		* Sets tile's j(row) coordinate 
		*/
		public function set j(value:int):void
		{
			_j = value;
		}

		/*
		* Returns tile's i(column) coordinate 
		*/
		public function get i():int
		{
			return _i;
		}

		/*
		* Sets tile's i(column) coordinate 
		*/
		public function set i(value:int):void
		{
			_i = value;
		}
		
		/*
		* Convertes tile row and column values to special String format. For tracing purposes.
		*/
		public function toString(): String {
			return "Tile i = " + i + " j = " + j;
		}

	}
}