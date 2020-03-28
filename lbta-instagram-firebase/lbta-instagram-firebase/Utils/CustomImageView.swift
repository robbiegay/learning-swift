//
//  CustomImageView.swift
//  lbta-instagram-firebase
//
//  Created by Robbie Gay on 3/28/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        lastURLUsedToLoadImage = urlString
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error getting image:",err)
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage { return }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
