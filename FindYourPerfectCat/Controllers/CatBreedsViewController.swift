//
//  CatBreedsViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 16.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit

class CatBreedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var breeds = [Breed]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)
        let curBreed = breeds[indexPath.row]
        
        cell.textLabel?.text = curBreed.name
        cell.detailTextLabel?.text = curBreed.description
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSONBreeds{
            self.tableView.reloadData()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func downloadJSONBreeds(completed: @escaping() -> ()){
        let url = NSURL(string: "https://api.thecatapi.com/v1/breeds")
        
        var request = URLRequest(url: url! as URL)
        request.addValue("2129fafd-26c9-4517-abe3-2ee5a4cfb3f9", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            if(error==nil){
                do{
                    self.breeds = try JSONDecoder().decode([Breed].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch{
                    print("JSON Error \(error)")
                }
            }
        }.resume()
    }
}
