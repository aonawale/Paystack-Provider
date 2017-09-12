import Vapor

public protocol PaystackModel: JSONRepresentable, BodyRepresentable {}

public extension PaystackModel {
    func makeBody() -> Body {
        guard let body = try? makeJSON().makeBody() else {
            return  Body("")
        }
        return body
    }
}

public struct Charge: PaystackModel {
    let card: Card
    let pin: String?
    let otp: String?
    let email: String
    let amount: Int

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("pin", pin)
        try json.set("otp", otp)
        try json.set("email", email)
        try json.set("amount", amount)
        try json.set("card", card.makeJSON())
        return json
    }
}