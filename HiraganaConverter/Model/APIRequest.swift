import Foundation
import RxSwift
import Moya

enum Result<ResponseModel: Codable, ErrorResponseModel: Codable> {
    case success(ResponseModel)
    case invalid(ErrorResponseModel)
    case failure(Error)
}

public final class APIRequest {

    private let provider = MoyaProvider<Target>()

    func request<ResponseModel: Codable, ErrorResponseModel: Codable>(target: Target, response: ResponseModel.Type, errorResponse: ErrorResponseModel.Type,
                                                                      completion: @escaping ((Result<ResponseModel, ErrorResponseModel>) -> Void )) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let serializedResponse = try response.filterSuccessfulStatusCodes().map(ResponseModel.self)
                    dump(serializedResponse)

                    completion(.success(serializedResponse))

                } catch {
                    guard let errorResponse = self.serializeError(response: response, errorResponse: errorResponse) else { completion(.failure(error)); return }
                    dump(errorResponse)

                    completion(.invalid(errorResponse))

                }
            case let .failure(error):
                dump(error)
                completion(.failure(error))
            }
        }
    }

    private func serializeError<ErrorResponseModel: Codable>(response: Moya.Response, errorResponse: ErrorResponseModel.Type) -> ErrorResponseModel? {
        do {
            let errorResponse = try response.map(ErrorResponseModel.self)
            dump(errorResponse)
            return errorResponse
        } catch {
            return nil
        }
    }
}
