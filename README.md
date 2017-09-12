# Vapor Paystack Provider

[![Language](https://img.shields.io/badge/Swift-3.1-brightgreen.svg)](http://swift.org)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/vapor-community/markdown-provider/master/LICENSE)

[Paystack](https://paystack.com/) is an easy to setup, complete payments solution for businesses.

## Setup

### Add the dependancy

Add PaystackProvider as a dependancy in your `Package.swift` file:

```swift
dependencies: [
  ...,
  .Package(url: "https://github.com/aonawale/paystack-provider.git", majorVersion: 1)]
]
`````

### Config

Paystack can be configured in a `paystack.json` file located inside your Vapor `Config` dir:

```json
{
    "publicKey": "your public key",
    "secretKey": "your secret key"
}
```

### Add the Provider

After you have initialized the `Config` object, simply add the provider:

```swift
import PaystackProvider
...
try config.addProvider(PaystackProvider.Provider.self)
```

## Use

PaystackProvider adds an extension on Droplet for easier access to Paystack, so it can be accessed simply as:

```swift
let paystack = droplet.paystack
```

### Charging a card

Send card details to start a charge:

```swift
import PaystackProvider

let card = Card(number: "4084084084084081", cvv: "408", expiryMonth: "02", expiryYear: "20")
try paystack.charge(card: card, amount: 1000, email: "me@email.com")
```
