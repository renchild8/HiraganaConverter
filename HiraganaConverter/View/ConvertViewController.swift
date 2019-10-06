import UIKit
import RxSwift
import RxCocoa

class ConvertViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hiraganaTextView: UITextView!
    @IBOutlet weak var hiraganaClearButton: UIButton!
    @IBOutlet weak var kanjiTextView: PlaceHolderedTextView!
    @IBOutlet weak var kanjiClearButton: UIButton!
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
        hiraganaClearButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.convertViewModel.clearOfHiragana()
            }.disposed(by: disposeBag)

        kanjiClearButton.rx.tap
            .subscribe {[weak self] _ in
                guard let self = self else { return }
                self.kanjiTextView.endEditing(true)
                self.convertViewModel.clearOfKanji()
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
        gooImageView.image = UIImage(url: "http://u.xgoo.jp/img/sgoo.png")
    }
    private func setDelegate() {
        kanjiTextView.delegate = self
    }

    func setupObserver() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ConvertViewController.keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(ConvertViewController.keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }

    @objc func keyboardWillShowNotification(_ notification: Notification) {

        guard let keyboardScreenEndFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let boundSize: CGSize = UIScreen.main.bounds.size
        let textViewBottom = kanjiTextView.frame.origin.y + kanjiTextView.frame.height
        let keyboardtop = boundSize.height - keyboardScreenEndFrame.size.height

        if textViewBottom >= keyboardtop {
            scrollView.contentOffset.y = textViewBottom / 2
        }
    }

    @objc func keyboardWillHideNotification(_ notification: Notification) {
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
