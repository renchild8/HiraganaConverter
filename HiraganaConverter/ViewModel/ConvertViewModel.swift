import RxSwift
import RxCocoa

class ConvertViewModel {
    var hiragana = BehaviorRelay<String>(value: "ここにひらがなが表示されます")
    var kanji = BehaviorRelay<String>(value: "")

    private let apiRequest = APIRequest()

    func clearText() {
        kanji.accept("")
        hiragana.accept("")
    }

    func convert() {

        guard  kanji.value != "" else {
            AlertManager.dispAlert(title: ErrorMessage.error, message: ErrorMessage.kanjiEmpty)
            return
        }

        apiRequest.request(target: .hiragana(sentence: kanji.value ), response: HiraganaResponse.self, errorResponse: HiraganaErrorResponse.self) { respose in
            switch respose {
            case .success(let hiraganaResponse):
                self.hiragana.accept(hiraganaResponse.converted)
            case .invalid(let errorResponse):
                print(errorResponse)
                AlertManager.dispAlert(title: String(errorResponse.error.code), message: errorResponse.error.message)
            case .failure(let error):
                print(error)
                AlertManager.dispAlert(title: ErrorMessage.error, message: error.localizedDescription)
            }
        }

    }

}
