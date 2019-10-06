import UIKit
import RxSwift
import RxCocoa

class ConvertViewController: UIViewController {

    @IBOutlet weak var hiraganaTextView: UITextView!
    @IBOutlet weak var kanjiTextView: PlaceHolderedTextView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var gooImageView: UIImageView!

    private let convertViewModel = ConvertViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        bind()
        setImage()
    }

    private func setupButton() {
        convertButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.convertViewModel.convert()
            }.disposed(by: disposeBag)
    }

    private func bind() {
        kanjiTextView.rx.text.orEmpty
            .bind(to: convertViewModel.kanji)
            .disposed(by: disposeBag)

        convertViewModel.hiragana
            .bind(to: hiraganaTextView.rx.text)
            .disposed(by: disposeBag)
    }

    private func setImage() {
        gooImageView.image = UIImage(url: "http://u.xgoo.jp/img/sgoo.png")
    }

}
