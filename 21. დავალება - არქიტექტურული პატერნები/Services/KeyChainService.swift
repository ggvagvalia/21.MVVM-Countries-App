//
//  KeyChainService.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/26/24.
//

import Foundation
//import UIKit
import Security


class KeyChainService {
    static let shared = KeyChainService()
    let serviceIdentifier = "com.example.myapp.credentials"
    struct Credentials {
        let username: String
        let password: String
    }
    
    enum KeyChainError: Error {
        case sameItemFound
        case unknown
        case nosuchDataFound
        case KCErrorWithCode(Int)
    }
    
    func saveCredentials(
        username: String,
        password: String
    ) {
        guard let passwordData = password.data(using: .utf8) else {
            print("Failed to convert password to data")
            return
        }
        
        do {
            try save(
                service: serviceIdentifier,
                account: username,
                password: passwordData
            )
            print("Credentials saved successfully")
        } catch {
            print("Error saving credentials: \(error)")
        }
    }
    
    func getSavedCredentials() -> Credentials? {
        guard let username = getUsername(), let password = getPassword(forUsername: username) else {
            return nil
        }
        return Credentials(username: username, password: password)
    }
    func getUsername() -> String? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: kCFBooleanTrue as AnyObject
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let existingItem = item as? [String: Any],
              let account = existingItem[kSecAttrAccount as String] as? String else {
            return nil
        }
        
        return account
    }
    
    func getPassword(forUsername username: String) -> String? {
        guard let data = get(service: serviceIdentifier, account: username) else {
            print("Failed to load password")
            return nil
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    // MARK: - ⬇️SAVE data
    func save(
        service: String,
        account: String,
        password: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String         : kSecClassGenericPassword,
            kSecAttrService as String   : service as AnyObject,
            kSecAttrAccount as String   : account as AnyObject,
            kSecValueData as String     : password as AnyObject,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeyChainError.sameItemFound
        }
        guard status == errSecSuccess else {
            throw KeyChainError.unknown
        }
        
        print("credentials saved")
    }
    
    func isLoggedIn(username: String) -> Bool {
        return KeyChainService.shared.getPassword(forUsername: username) != nil
    }
    
    // MARK: - ⬆️GET data
    func get(
        service: String,
        account: String
    ) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            print("Error retrieving data from Keychain: \(status)")
            return nil
        }
        
        return result as? Data
    }
}
