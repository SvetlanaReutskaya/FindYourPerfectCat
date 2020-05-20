//
//  CatBreedsViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 16.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var breeds = [Breed]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! BreedViewCell
        let curBreed = breeds[indexPath.row]
        
        cell.breedName.text = curBreed.name
        cell.breedDescription.text = curBreed.temperament
        cell.breedDescription.isEditable = false
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BreedViewController{
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
            if error == nil {
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
