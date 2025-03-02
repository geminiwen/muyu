import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    private lazy var methodChannel : FlutterMethodChannel = {
        let flutterViewController = self.mainFlutterWindow!.contentViewController as! FlutterViewController
        
        let binaryMessenger = flutterViewController.engine.binaryMessenger
    
        return FlutterMethodChannel(
            name: "com.geminiwen.muyu/channel",
            binaryMessenger: binaryMessenger
        )
    }()

  @IBAction func showPreferences(_ sender: Any?) {
    self.methodChannel.invokeMethod("openSettings", arguments: nil)
  }
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
  
}
