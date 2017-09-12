import Vapor

public struct Card: PaystackModel {
    let cvv: String
    let number: String
    let expiryYear: String
    let expiryMonth: String

    public init(number: String, cvv: String, expiryMonth: String, expiryYear: String) {
        self.cvv = cvv
        self.number = number
        self.expiryYear = expiryYear
        self.expiryMonth = expiryMonth
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("cvv", cvv)
        try json.set("number", number)
        try json.set("expiry_year", expiryYear)
        try json.set("expiry_month", expiryMonth)
        return json
    }
}