//
//  ViewController.swift
//  Example
//
//  Created by Pavel Moslienko on 25 июля 2023 г..
//  Copyright © 2023 Pavel Moslienko. All rights reserved.
//

import UIKit
import AppleAuthenticationWrapper
import AuthenticationServices

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {
    
    // MARK: Properties
    
    /// The Label
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "🚀\nAppleAuthenticationWrapper\nExample"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    // MARK: View-Lifecycle
    
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let appleSignInButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
        appleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        appleSignInButton.addTarget(self, action: #selector(appleSignInBtnTapped), for: .touchUpInside)
        
        view.addSubview(appleSignInButton)
        NSLayoutConstraint.activate([
            appleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleSignInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// LoadView
    override func loadView() {
        self.view = UIView()
    }
    
    @objc
    private func appleSignInBtnTapped() {
        let authWrapper = AppleAuthenticationWrapper()
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
    }
}
