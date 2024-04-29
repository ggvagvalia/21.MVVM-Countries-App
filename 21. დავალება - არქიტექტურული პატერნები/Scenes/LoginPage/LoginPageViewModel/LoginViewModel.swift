//
//  LoginViewModel.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/26/24.
//

import Foundation


class LoginViewModel {
    
    // MARK: - Properties
    weak var delegate: CountryViewModelDelegate?
    var navigateToMainVC: (() -> Void)?
//    let userSignedInKey = "userSignedIn"
    var loggedInUsername: String?
    
    
    // MARK: - SaveUser/Password
    func save(username: String, password: String) {
        guard let passwordData = password.data(using: .utf8) else {
            print("Failed to convert password to data")
            return
        }
        
        do {
            try KeyChainService.shared.save(service: "com.example.myapp.credentials", account: username, password: passwordData)
            print("Credentials saved successfully")
            loggedInUsername = username
            navigateToMainVC?()
        } catch {
            print("Error saving credentials: \(error)")
        }
    }
    
    //    //     MARK: - AutoLogin
    //            func autoLogin() {
    //                if let savedCredentials = KeyChainService.shared.getSavedCredentials() {
    //                    print("Auto-Login Successful!")
    //                    loggedInUsername = savedCredentials.username
    //                    if !isUserSignedIn() {
    //                        save(username: savedCredentials.username, password: savedCredentials.password)
    //                        UserDefaults.standard.setValue(true, forKey: userSignedInKey)
    //                        UserDefaults.standard.synchronize()
    //                        navigateToMainVC?()
    //                    }
    //                } else {
    //                    print("No saved credentials found.")
    //                }
    //            }
    //
    //            func isUserSignedIn() -> Bool {
    //                return UserDefaults.standard.bool(forKey: userSignedInKey)
    //            }
    
}
