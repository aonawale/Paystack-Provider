import XCTest
import PaystackProvider
import SMTP
@testable import Vapor

class PaystackProviderTests: XCTestCase {
    static let allTests = [
        ("testDroplet", testDroplet),
        ("testCharge", testCharge),
    ]

    let publicKey = "YOUR_PUBLIC_KEY" // Set here, but don't commit to git!
    let secretKey = "YOUR_SECRET_KEY" // Set here, but don't commit to git!
    func testDroplet() throws {
        let config: Config = try [
            "paystack": [
                "publicKey": publicKey,
                "secretKey": secretKey
            ],
        ].makeNode(in: nil).converted()
        try config.addProvider(Provider.self)
        let drop = try Droplet(config)
        guard let _ = drop.paystack as? Paystack else {
            XCTFail("drop.paystack is \(drop.mail)")
            return
        }
    }

    func testCharge() throws {
        if apiKey == "YOUR_API_KEY" {
            print("*** Not testing ElasticEmail as no API Key is set")
            return
        }
        let config: Config = try [
            "elasticemail": [
                "apiKey": apiKey
            ],
        ].makeNode(in: nil).converted()
        let elasticemail = try ElasticEmail(config: config)
        let email = Email(from: "vapor-elasticemail-from@mailinator.com",
                          to: "vapor-elasticemail@mailinator.com",
                          subject: "Email Subject",
                          body: "Hello Email")

        try elasticemail.send(email)
    }

}
