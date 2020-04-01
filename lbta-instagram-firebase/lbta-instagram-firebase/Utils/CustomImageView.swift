//
//  CustomImageView.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/28/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        // If an image in the cache exisits that matchs the image url,
        // load the image from the cache and return out of the loadImage func
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        lastURLUsedToLoadImage = urlString
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error getting image:",err)
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage { return }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            imageCache[url.absoluteString] = image
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}



