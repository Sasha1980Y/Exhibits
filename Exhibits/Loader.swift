//
//  Loader.swift
//  Exhibitі_Test
//
//  Created by Alexander Yakovenko on 4/12/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class Loader {
    static let shared = Loader()
    
    var array: [Exhibit] = []
    
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
    
    // add image
    
    
    
    
    
    
    // download image
    func download(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            Alamofire.request(url).responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                }
            }
        }
        
    }
 
}
