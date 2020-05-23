//
//  FavouritesViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 22.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var breedIds  = [String]()
    var breeds  = [Breed]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breedIds.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavViewCell
        
        let idStr = self.breedIds[indexPath.row]
        let breed = breeds.filter({$0.id == idStr})[0]
        let breedImg = defaults.string(forKey: idStr)
            
        cell.breedName.text = breed.name
        cell.breedInfo.text = breed.description
        cell.breedInfo.isEditable = false
        if breedImg != nil {
            cell.breedImg.downloaded(from: breedImg!)
        }
        return cell
    }
}
