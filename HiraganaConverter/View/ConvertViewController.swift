import UIKit
import RxSwift
import RxCocoa

class ConvertViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hiraganaTextView: UITextView!
    @IBOutlet weak var kanjiTextView: PlaceHolderedTextView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var gooImageView: UIImageView!

    private let convertViewModel = ConvertViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        bind()
        setImage()
        setDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeObserver()
    }

    private func setupButton() {
        clearButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.kanjiTextView.endEditing(true)
                self.convertViewModel.clearText()
        }.disposed(by: disposeBag)

        convertButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.kanjiTextView.endEditing(true)
                self.convertViewModel.convert()
        }.disposed(by: disposeBag)
    }

    private func bind() {
        kanjiTextView.rx.text.orEmpty
            .bind(to: convertViewModel.kanji)
            .disposed(by: disposeBag)

        convertViewModel.kanji
            .bind(to: kanjiTextView.rx.text)
            .disposed(by: disposeBag)

        convertViewModel.hiragana
            .bind(to: hiraganaTextView.rx.text)
            .disposed(by: disposeBag)
    }

    private func setImage() {
        gooImageView.image = UIImage(url: Const.gooImageURL)
    }

    private func setDelegate() {
        kanjiTextView.delegate = self
    }

    private func setupObserver() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ConvertViewController.keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }

    @objc private func keyboardWillHideNotification(_ notification: Notification) {
        scrollView.contentOffset.y = 0
    }
}

extension ConvertViewController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        scrollView.isScrollEnabled = true
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.isScrollEnabled = false
    }

}
