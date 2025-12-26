
import SwiftUI

struct NSAlertWithSwiftUIDemo: View {
    
    var body: some View {
        VStack {
            Button(action: {
                self.showBasicAlert()
            }, label: {
                Text("Basic")
            })
            
            Button(action: {
                self.showAlertMultipleButtonsWithOrder()
            }, label: {
                Text("Multiple")
            })
            
            Button(action: {
                self.showAlertWithSuppress()
            }, label: {
                Text("With Suppress")
            })

        }
    }
    
    // It is really important to make sure that the NSAlert runModal is called from the main thread.
    // Otherwise, the app might freeze.
    //
    // we don't have any problem here since we are calling it from view, but it is really important to ensure this when calling from a manager class or from some non-isolated context.
    @MainActor
    private func showBasicAlert() {
        let alert = NSAlert()
        alert.messageText = "Title"
        alert.informativeText = "message"
        
        alert.alertStyle = .warning
        
        // Icon An optional, custom icon to display in the alert, which is used instead of the default app icon. Specified with icon.
        alert.icon = NSImage(systemSymbolName: "star.fill", accessibilityDescription: nil)
        alert.window.level = .floating
        alert.window.collectionBehavior = [.moveToActiveSpace]
        
        alert.addButton(withTitle: "OK")
        _ = alert.runModal()
    }
    
    
    @MainActor
    private func showAlertMultipleButtons() {
        let alert = NSAlert()
        alert.messageText = "Title"
        
        let okButton = alert.addButton(withTitle: "OK")
        okButton.tag = NSApplication.ModalResponse.OK.rawValue
        
        let cancelButton = alert.addButton(withTitle: "Cancel")
        cancelButton.tag = NSApplication.ModalResponse.cancel.rawValue

        let dangerButton = alert.addButton(withTitle: "Delete")
        dangerButton.tag = NSApplication.ModalResponse.abort.rawValue
        dangerButton.hasDestructiveAction = true

        let result = alert.runModal()
        
        switch result {
        case .OK:
            print("Ok")
        case .cancel:
            print("cancel")
        case .abort:
            print("Danger")
        default:
            print("result: \(result)")
        }
    }
    
    @MainActor
    private func showAlertMultipleButtonsWithOrder() {
        let alert = NSAlert()
        alert.messageText = "Title"
        
        let _ = alert.addButton(withTitle: "OK")
        
        let _ = alert.addButton(withTitle: "Cancel")

        let dangerButton = alert.addButton(withTitle: "Delete")
        dangerButton.hasDestructiveAction = true

        let result = alert.runModal()
        
        switch result {
        case .alertFirstButtonReturn:
            print("Ok")
        case .alertSecondButtonReturn:
            print("cancel")
        case .alertThirdButtonReturn:
            print("Danger")
        default:
            print("result: \(result)")
        }
    }
    
    private let alertWithSuppression = NSAlert()
    
    @MainActor
    private func showAlertWithSuppress() {
        if alertWithSuppression.suppressionButton?.state == .on {
            print("suppressed")
            return
        }
        alertWithSuppression.messageText = "Title"
        alertWithSuppression.informativeText = "message"
        alertWithSuppression.showsSuppressionButton = true
        alertWithSuppression.suppressionButton?.title = "You don't want to see me again?"
        
        _ = alertWithSuppression.runModal()
    }
    
    
    @MainActor
    private func showAlertWithHelp() {
        let alert = NSAlert()
        alert.messageText = "Title"
        alert.informativeText = "message"
        
        alert.alertStyle = .warning
        
        // Icon An optional, custom icon to display in the alert, which is used instead of the default app icon. Specified with icon.
        alert.icon = NSImage(systemSymbolName: "star.fill", accessibilityDescription: nil)
        
        alert.addButton(withTitle: "OK")
        _ = alert.runModal()
    }

}
