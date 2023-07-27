//
//  Extension+ASAuthorizationAppleIDCredential.swift
//  AppleAuthenticationWrapper
//
//  Created by Pavel Moslienko on 25.07.2023.
//  Copyright © 2023 Pavel Moslienko. All rights reserved.
//

import Foundation
import AuthenticationServices

public extension ASAuthorizationAppleIDCredential {
    
    var token: String? {
        if let appleIDToken = self.identityToken {
            return String(data: appleIDToken, encoding: .utf8)
        }
        return nil
    }
}
