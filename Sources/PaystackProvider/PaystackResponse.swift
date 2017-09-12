import HTTP
import Vapor

/// PaystackResponse
/// A wrapper object around Vapor HTTP.Response object
/// that helps extract important Paystack responses
/// from the response and expose them as properties
public struct PaystackResponse {
    let status: Bool
    let message: String
    let data: JSON

    /// Vapor HTTP.Response object
    let response: Response

    public var isSuccess: Bool {
        return status
            && 200 == response.status.statusCode
            && data["status"] == "success"
    }

    public var isFailure: Bool {
        return status
            && 200 == response.status.statusCode
            && data["status"] == "failed"
    }

    public var reference: String? {
        return data["reference"]?.string
    }

    init(response: Response) {
        self.response = response
        let json = response.json ?? JSON()
        self.status = json["status"]?.bool ?? false
        self.message = json["message"]?.string ?? ""
        self.data = JSON(json["data"]?.object ?? [:])
    }
}