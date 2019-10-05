import UIKit

class AlertManager {
    static func dispAlert(title: String, message: String,
                          completion:@escaping ((_ text: String) -> Void) = { (_ text: String) -> Void in print("OK") }) {

        guard let topController = UIApplication.topViewController() else { return }
        guard !(topController is UIAlertController) else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)

        topController.present(alert, animated: true, completion: nil)
    }
}
