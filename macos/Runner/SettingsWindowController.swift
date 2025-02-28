import Cocoa
import FlutterMacOS

class SettingsWindowController: NSWindowController {
    static let shared = SettingsWindowController()
    
    init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = "Settings"
        window.center()
        
        super.init(window: window)
        
        let flutterViewController = FlutterViewController()
        window.contentViewController = flutterViewController
        
        // Register plugins for the settings view
        RegisterGeneratedPlugins(registry: flutterViewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}