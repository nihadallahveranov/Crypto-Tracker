# Crypto Tracker App

Crypto Tracker App is an iOS application that allows users to track the rates of various cryptocurrencies. It provides real-time updates on the rates of popular cryptocurrencies such as Bitcoin, Ethereum, and Ripple. Users can set custom minimum and maximum rate alerts for each coin and receive notifications when the rates cross those thresholds. The app also maintains a history of coin rates for reference.

## Features

- View currency rates for Bitcoin, Ethereum, and Ripple on the home page
- Set custom minimum and maximum rate alerts for each coin
- Receive notifications when the coin rates exceed the set thresholds
- View the history of coin rates
- Use of the CoinGecko API for fetching the latest rates

## Technologies and Frameworks

The Crypto Tracker App is built using the following technologies and frameworks:

- Swift
- MVVM (Model-View-ViewModel) architecture
- UIKit for the user interface
- Alamofire for networking tasks
- UserNotifications for local notifications
- UserDefaults for storing user preferences
- XCTest for unit testing

## Installation and Setup

1. Clone the repository to your local machine.
2. Open the Xcode project file (`CryptoTracker.xcworkspace`).
3. Build and run the project in Xcode using a simulator or a connected iOS device.

## Usage

- Launch the app to see the home page with the currency rates.
- Tap on a coin to set the minimum and maximum rate alerts for that coin.
- Enter the desired values and save.
- The app will monitor the rates in the background and send notifications when the thresholds are crossed.
- Tap on the "History" button to view the historical rates for each coin.

## Contributing

Contributions to the Crypto Tracker App are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.

## License

The Crypto Tracker App is open-source and available under the [MIT License](LICENSE).
