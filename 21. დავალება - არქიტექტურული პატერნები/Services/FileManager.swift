//
//  FileManager.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/27/24.
//

import Foundation
import UIKit

class FileManagerServise {
    
    static let shared = FileManagerServise()
    
    func saveImageToDocumentsDirectory(image: UIImage) -> URL? {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found")
            return nil
        }
        guard let imageData = image.pngData() else {
            print("Failed to convert image to data")
            return nil
        }
        
        let fileURLs = try? FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
        if let existingURL = fileURLs?.first(where: { url -> Bool in
            guard let data = try? Data(contentsOf: url) else { return false }
            return data == imageData
        }) {
            print("Image already exists at: \(existingURL)")
            return existingURL
        }
        
        let fileName = UUID().uuidString + ".png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: fileURL)
            print("Image saved to: \(fileURL.absoluteString)")
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}
