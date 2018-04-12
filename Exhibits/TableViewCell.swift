//
//  TableViewCell.swift
//  Exhibits
//
//  Created by Alexander Yakovenko on 4/12/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TableViewCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        collectionView.dataSource = self
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Loader.shared.array[collectionView.tag].imageURL.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        
        
        
        
        cell.title.text = Loader.shared.array[collectionView.tag].title
        print(cell.title.text)
        
        let url = Loader.shared.array[collectionView.tag].imageURL[indexPath.row]
            Alamofire.request(url).responseImage { response in
                //debugPrint(response)
                
                //print(response.request)
                //print(response.response)
                //debugPrint(response.result)
                
                if let image = response.result.value {
                    
                    cell.image.image = image
                    print("image downloaded: \(image)")
                    print("url", url)
                }
            }
        
        
        return cell
    }
    

}
