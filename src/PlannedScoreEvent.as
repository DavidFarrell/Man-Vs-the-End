package
{
	public class PlannedScoreEvent extends PlannedEvent
	{
		/*
		 * This type of planned event compares the passed in score against a defined score.
		 * If the player's score is higher than the predefined value, we execute the callback.
		 */
		
		public function PlannedScoreEvent(type:uint, parameters:Array, callbackO:Object, callbackF:Function)
		{
			super(type, parameters, callbackO, callbackF);
		}
		
		public function checkPlan( score : Number, timePassed : Number) {
			if ( score > (params[0] as Number) ) {
				callbackObject[callbackFunction]();
			}	
		}
	}
}