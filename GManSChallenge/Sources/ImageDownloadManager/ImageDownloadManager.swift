//
//  ImageDownloadManager.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import UIKit

var imageDownloadQueue: OperationQueue = {
   var queue = OperationQueue()
   queue.name = "com.imagedownload.imageDownloadqueue"
   queue.qualityOfService = .userInteractive
   return queue
}()

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    // Download image from Image url & save to document directory & Image Cache
    func downloadImage(_ imageUrl: String, activityView: UIActivityIndicatorView) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        self.image = nil
        let fileName = url.lastPathComponent

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            /* check for the cached image for url, if YES then return the cached image */
            print("Return cached Image for \(url)")
            self.image = cachedImage
        } else if let cachedImage = FileManager.loadImageFromDocumentDirectory(fileName: fileName) {
            /* check for the cached image in Document Directory for url, if YES then return the cached image */
            print("Return cached Image for \(url)")
            self.image = cachedImage
        } else {
            activityView.startAnimating()
            /* check if there is a download task that is currently downloading the same image. */
            if let operations = (imageDownloadQueue.operations as? [ImageOperation])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
                print("Increase the priority for \(url)")
                operation.queuePriority = .veryHigh
            }else {
                /* create a new task to download the image.  */
                print("Create a new task for \(url)")
                let operation = ImageOperation(url: url, indexPath: nil)
                operation.queuePriority = .high
                operation.downloadHandler = { [weak self] (image, url, indexPath, error) in
                    DispatchQueue.main.async {
                        if let newImage = image {
                            imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                            _ = FileManager.saveImageInDocumentDirectory(image: newImage, fileName: fileName)
                        } else {
                            print("Image found nil for \(url)")
                        }
                        self?.image = image
                        activityView.stopAnimating()
                        activityView.hidesWhenStopped = true
                    }
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }

    /* FUNCTION to reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
    func slowDownImageDownloadTaskfor (_ flickrUrl: String) {
        guard let url = URL(string: flickrUrl) else {
            return
        }
        if let operations = (imageDownloadQueue.operations as? [ImageOperation])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
            print("Reduce the priority for \(url)")
            operation.queuePriority = .low
        }
    }

    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
}
