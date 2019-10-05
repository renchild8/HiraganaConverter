import UIKit
import RxSwift
import RxCocoa

class ConvertViewController: UIViewController {

    @IBOutlet weak var hiraganaLabel: UILabel!
    @IBOutlet weak var kanjiTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!

    private let convertViewModel = ConvertViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        bind()
    }

    private func setupButton() {
        convertButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.convertViewModel.convert()
            }.disposed(by: disposeBag)
    }

    private func bind() {
        kanjiTextField.rx.text.orEmpty
            .bind(to: convertViewModel.kanji)
            .disposed(by: disposeBag)

        convertViewModel.hiragana
            .bind(to: hiraganaLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
