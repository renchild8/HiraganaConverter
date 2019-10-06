import UIKit

extension CALayer {
    @objc dynamic var borderUIColor: UIColor {
        get {
            // swiftlint:disable force_unwrapping
            return UIColor(cgColor: self.borderColor!)
            // swiftlint:enable force_unwrapping
        } set {
            self.borderColor = newValue.cgColor
        }
    }
}
