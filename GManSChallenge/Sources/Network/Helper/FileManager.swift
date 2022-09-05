//
//  FileManager.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 03/09/22.
//

import UIKit

extension FileManager {
    static func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileURL
        }
        return nil
    }

    static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }
}
