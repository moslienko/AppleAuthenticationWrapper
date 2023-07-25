//
//  AppleAuthenticationWrapper.swift
//  AppleAuthenticationWrapper
//
//  Created by Pavel Moslienko on 25 июля 2023 г..
//  Copyright © 2023 Pavel Moslienko. All rights reserved.
//

import Foundation
import AuthenticationServices
import CryptoKit

public typealias SuccessAppleAuth = ((ASAuthorizationAppleIDCredential) -> Void)
public typealias FailedAppleAuth = ((Error?) -> Void)

public class AppleAuthenticationWrapper: UIViewController {
    
    // Unhashed nonce.
    public var currentNonce: String?
    // Callback
    private var successAuth: SuccessAppleAuth?
    private var failedAuth: FailedAppleAuth?
    
    private weak var parentVC: UIViewController?
    
    public func signInViaApple(from vc: UIViewController, requestedScopes: [ASAuthorization.Scope], successAuth: @escaping SuccessAppleAuth, failedAuth: FailedAppleAuth?) {
        self.parentVC = vc
        self.successAuth = successAuth
        self.failedAuth = failedAuth
        
        //Open screen for correct working
        self.view.backgroundColor = .clear
        self.modalPresentationStyle = .overFullScreen
        self.parentVC?.present(self, animated: false)
        
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = requestedScopes
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthenticationWrapper: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("didCompleteWithAuthorization")
        self.dismiss(animated: false)
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to fetch identity token")
            self.failedAuth?(nil)
            return
        }
        self.successAuth?(appleIDCredential)
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.dismiss(animated: false)
        guard (error as NSError).code != 1001 else {
            self.failedAuth?(nil)
            return
        }
        self.failedAuth?(error)
    }
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.parentVC?.view.window ?? UIWindow()
    }
}

private extension AppleAuthenticationWrapper {
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        guard errorCode == errSecSuccess else {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { byte in
            let index = Int(byte) % charset.count
            return charset[index]
        }
        
        return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
