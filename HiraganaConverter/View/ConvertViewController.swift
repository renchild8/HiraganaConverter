import UIKit
import RxSwift
import RxCocoa

class ConvertViewController: UIViewController {

    @IBOutlet weak var hiraganaLabel: UILabel!
    @IBOutlet weak var kanjiTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupButton() {
        convertButton.rx.tap
            .subscribe { _ in
                self.convert()
            }.disposed(by: disposeBag)
    }

    func convert() {

    }
}
