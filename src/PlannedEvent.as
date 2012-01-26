package
{
	public class PlannedEvent
	{
		public var criteriaType : uint;
		public var params : Array;
		public var callbackObject : Object;
		public var callbackFunction : Function;
		
		
		public function PlannedEvent(type : uint, parameters : Array, callbackO : Object, callbackF : Function)
		{
			criteriaType = type;
			params = parameters;
			callbackObject = callbackO;
			callbackFunction = callbackF;
		}
		
		public function checkPlan( score : Number, timePassed : Number) {
			
		}
	}
}