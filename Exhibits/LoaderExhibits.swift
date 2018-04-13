//
//  LoaderExhibits.swift
//  Exhibits
//
//  Created by Alexander Yakovenko on 4/13/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation

protocol LoaderExhibitsDelegate: class {
    func downloadExhibit(block: @escaping () -> Void)
}


class LoaderExhibits {
    weak var delegate: LoaderExhibitsDelegate?
    
    func start() {
        delegate?.downloadExhibit(block: {
            print("ok")
        })
    }
    
    
}
extension LoaderExhibits {
    
    // download Model
    func downloadExhibit(block: @escaping () -> Void) {
        var exhibit: [Exhibit]? = []
        let stringUrl = "https://goo.gl/t1qKMS"
        
        guard let url = URL(string: stringUrl) else {
            print("url problem")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data else {
                return
            }
            guard error == nil else {
                return
            }
            do {
                let js =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                DispatchQueue.main.async {
                    if let dictionary = js as? [String: Any] {
                        
                        if let nestedDict = dictionary["list"] as? [[String: Any]] {
                            
                            for item in nestedDict {
                                
                                if let name = item["title"] as? String, let urlArray = item["images"] as? [String] {
                                    exhibit?.append(Exhibit(title: name, imageURL: urlArray))
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    if let arrayOfExhibit = exhibit {
                        Loader.shared.array = arrayOfExhibit
                        block()
                    }
                    
                }
                
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
    
}
