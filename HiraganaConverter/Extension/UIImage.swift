import UIKit

extension UIImage {
    public convenience init(url: String) {
        do {
            // swiftlint:disable force_unwrapping
            let data = try Data(contentsOf: URL(string: url)!)
            self.init(data: data)!
            // swiftlint:enable force_unwrapping
        } catch let err {
            print("Error : \(err.localizedDescription)")
            self.init()
        }
    }
}
