package
{
	import flash.text.TextField;
	import gs.control.DocumentController;
	import gs.remoting.RemotingCall;
	import gs.remoting.RemotingCallFault;
	import gs.remoting.RemotingCallResult;

	public class Main extends DocumentController
	{
		public var traceOut:TextField;
		private var rc:RemotingCall;
		
		override protected function flashvarsForStandalone():Object
		{
			return {
				model:"model.xml"
			};
		}
		
		override protected function onModelReady():void
		{
			super.onModelReady();
			rc = model.getRemotingCallById("rubyamf", "getWidgets");			
			rc.setCallbacks( { onResult:onres, onFault:onfal, onConnectFail:fail } );
			rc.clearListenersOnSuccess = true;
			rc.send();			
		}
		
		private function fail():void
		{
			trace("gateway connection fault");
			this.traceOut.text = "gateway connection fault";
		}
		
		private function onres(r:RemotingCallResult):void
		{			
			trace(r.result.toString());
			this.traceOut.text = r.result.toString();
		}
		
		private function onfal(f:RemotingCallFault):void
		{
			trace(f, f.fault, "fault");
			this.traceOut.text = f + f.fault + "fault";
		}
	}
}