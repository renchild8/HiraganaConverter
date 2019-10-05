struct HiraganaResponse: Codable {
    let converted: String
    let outputType: String
    let requestId: String

    private enum CodingKeys: String, CodingKey {
        case converted
        case outputType = "output_type"
        case requestId = "request_id"
    }
}
