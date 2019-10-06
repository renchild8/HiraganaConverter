import RxSwift
import RxCocoa

class ConvertViewModel {
    var kanji = BehaviorRelay<String>(value: "")
    var hiragana = BehaviorRelay<String>(value: "ここにひらがなが表示されます")

    private let apiRequest = APIRequest()

    func convert() {

        guard  kanji.value != "" else {
            AlertManager.dispAlert(title: "Error", message: "入力欄が空です")
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
                AlertManager.dispAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

}
