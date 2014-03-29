package tilemap
{
	public interface ITile
	{
		/*
		 * Returns tile's j(row) coordinate 
		*/
		function get j():int;
		
		/*
		* Sets tile's j(row) coordinate 
		*/
		function set j(value:int):void;
		
		/*
		* Returns tile's i(column) coordinate 
		*/
		function get i():int;
		
		/*
		* Sets tile's i(column) coordinate 
		*/
		function set i(value:int):void;
		
		/*
		* Convertes tile row and column values to special String format. For tracing purposes.
		*/
		function toString(): String;
	}
}