import Foundation
import Moya

enum Target {
    case hiragana(sentence: String)
}

extension Target: TargetType {

    var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: "https://labs.goo.ne.jp/api/")!
        // swiftlint:enable force_unwrapping
    }

    var path: String {
        switch self {
        case .hiragana:
            return "hiragana"
        }
    }

    var method: Moya.Method {
        switch self {
        case .hiragana:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var parameters = [
            "app_id" : "Your app ID"
        ]

        switch self {
        case .hiragana(let sentence):
            parameters["output_type"] = "hiragana"
            parameters["sentence"] = sentence
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }

    }

    var headers: [String: String]? {
        switch self {
        case .hiragana:
            return ["Content-Type" : "application/json"]
        }
    }

}
