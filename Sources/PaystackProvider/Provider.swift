import Vapor

public final class Provider: Vapor.Provider {
    private let paystack: Paystack
    public static let repositoryName = "paystack-provider"

    public init(config: Config) throws {
        guard let paystack = config["paystack"] else {
            throw ConfigError.missingFile("paystack")
        }
        guard let secretKey = paystack["secretKey"]?.string else {
            throw ConfigError.missing(key: ["secretKey"], file: "paystack", desiredType: String.self)
        }
        self.paystack = Paystack(secretKey: secretKey)
    }

    public func boot(_ config: Config) throws {}

    public func boot(_ droplet: Droplet) throws {
        droplet.storage["paystack"] = self.paystack
    }

    public func beforeRun(_ drop: Droplet) {}
}

extension Droplet {
    /// Convenience method for accessing paystack object.
    ///
    /// Note that accessing this property might crash the app if the PaystackProvider is not added.
    /// This tradeoff was done on purpose in order to gain a cleaner API (without optionals).
    public var paystack: Paystack {
        guard let paystack = self.storage["paystack"] as? Paystack else {
            fatalError("Paystack is not initialized. Make sure you have registered the provider by doing: `config.addProvider(PaystackProvider.Provider.self)`.")
        }

        return paystack
    }
}
