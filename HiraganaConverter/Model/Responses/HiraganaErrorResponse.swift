struct HiraganaErrorResponse: Codable {
    let error: HiraganaError

    struct HiraganaError: Codable {
        public let code: Int
        public let message: String
    }
}
