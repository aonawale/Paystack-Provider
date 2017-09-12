import HTTP
import Vapor

public final class Paystack {
    private let secretKey: String
    private let client = EngineClient.factory
    private static let host = "https://api.paystack.co"

    public init(secretKey: String) {
        self.secretKey = secretKey
    }

    public func charge(card: Card, amount: Int, email: String) throws -> PaystackResponse {
        let charge = Charge(card: card, pin: nil, otp: nil, email: email, amount: amount)
        return try request(.charge, body: charge.makeBody())
    }

    private func request(_ endpoint: Endpoint, body: BodyRepresentable) throws -> PaystackResponse {
        let headers = [
            HeaderKey("Content-Type"): "application/json",
            HeaderKey("Authorization"): "Bearer \(secretKey)"
        ]
        let uri = "\(Paystack.host)/\(endpoint.path)"
        let response = try client.post(uri, headers, body, through: [])

        return PaystackResponse(response: response)
    }
}

extension Paystack {
    enum Endpoint: String {
        case charge

        var path: String {
            return rawValue
        }
    }
}
