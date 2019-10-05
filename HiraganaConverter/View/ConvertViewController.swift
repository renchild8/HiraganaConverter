import UIKit
import RxSwift
import RxCocoa

class ConvertViewController: UIViewController {

    @IBOutlet weak var hiraganaLabel: UILabel!
    @IBOutlet weak var kanjiTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!

    let apiRequest = APIRequest()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }

    func setupButton() {
        convertButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.convert()
            }.disposed(by: disposeBag)
    }

    func convert() {
        apiRequest.request(target: .hiragana(sentence: "漢字"), response: HiraganaResponse.self, errorResponse: HiraganaErrorResponse.self) { respose in
            switch respose {
            case .success(let value):
                print(value.converted)
            case .invalid(let errorResponse):
                self.dispAlert(self, title: String(errorResponse.error.code), message: errorResponse.error.message)
            case .failure(let error):
                self.dispAlert(self, title: "Error", message: error.localizedDescription)
            }
        }
    }

    func dispAlert(_ viewController: UIViewController, title: String, message: String,
                   completion:@escaping ((_ text: String) -> Void) = { (_ text: String) -> Void in print("OK") }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)

        viewController.present(alert, animated: true, completion: nil)
    }
}
