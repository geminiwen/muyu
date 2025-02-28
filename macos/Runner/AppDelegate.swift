import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  @IBAction func showPreferences(_ sender: Any?) {
    SettingsWindowController.shared.showWindow(nil)
  }
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
  
  override func applicationDidFinishLaunching(_ notification: Notification) {
    super.applicationDidFinishLaunching(notification)
    
    if let preferencesMenuItem = NSApp.mainMenu?.items.first?.submenu?.items.first(where: { $0.title == "Settings.." }) {
      preferencesMenuItem.target = self
      preferencesMenuItem.action = #selector(showPreferences(_:))
    }
  }
}
