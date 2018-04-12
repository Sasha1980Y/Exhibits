//
//  ViewController.swift
//  Exhibits
//
//  Created by Alexander Yakovenko on 4/12/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        Loader.shared.downloadExhibit {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for item in Loader.shared.array {
            print("tableview")
            print(item.title)
            for itemUrl in item.imageURL {
                print(itemUrl)
            }
            print("endTableView")
        }
        return Loader.shared.array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        
        
        return cell
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

