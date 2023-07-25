<p align="center">
   <img width="200" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKitLogo.png" alt="AppleAuthenticationWrapper Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat" alt="Swift 5.2">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

# AppleAuthenticationWrapper

<p align="center">
ℹ️ Wrapper for quick authorization with Apple Sign In
</p>

## Example

The example application is the best way to see `AppleAuthenticationWrapper` in action. Simply open the `AppleAuthenticationWrapper.xcodeproj` and run the `Example` scheme.

## Installation

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/moslienko/AppleAuthenticationWrapper.git", from: "1.0.0")
]
```

Alternatively navigate to your Xcode project, select `Swift Packages` and click the `+` icon to search for `AppleAuthenticationWrapper`.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate AppleAuthenticationWrapper into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

Init wrapper class:

```swift
let authWrapper = AppleAuthenticationWrapper()
```

Checking if the user is logged:

```swift
func checkAuthStatus(userID: String, authorized: (() -> Void)?, notAuthorized: (() -> Void)?)
```

After successful authorization, you can immediately get a token and nonce:

```swift
authWrapper.signInViaApple(
    from: self,
    requestedScopes: [.email, .fullName],
    successAuth: { credential in
        print("Success auth, token \(credential.token), nonce - \(authWrapper.currentNonce)")
    },
    failedAuth: { error in
        print("Failed auth: \(String(describing: error?.localizedDescription))")
    }
)
 ```
 
## License

```
AppleAuthenticationWrapper
Copyright (c) 2023 Pavel Moslienko 8676976+moslienko@users.noreply.github.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
