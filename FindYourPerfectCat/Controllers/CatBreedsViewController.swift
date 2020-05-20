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
    var limit = 15
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)
        let curBreed = breeds[indexPath.row]
        
        cell.textLabel?.text = curBreed.name
        cell.detailTextLabel?.text = curBreed.temperament
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BreedInfoViewController{
            destination.breed = self.breeds[tableView.indexPathForSelectedRow?.row ?? 0]
        }
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
        let url = NSURL(string: CatApiResources.init().getBreeds)
        
        var request = URLRequest(url: url! as URL)
        request.addValue(CatApiResources.init().apiKey, forHTTPHeaderField: "x-api-key")
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
