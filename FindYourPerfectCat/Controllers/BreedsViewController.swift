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
    var searchBreeds = [Breed]()
    
    var searching = false
    var favourite = false
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        downloadJSONBreeds{
            self.tableView.reloadData()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(animated: animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchBreeds.count
        } else {
            return breeds.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! BreedViewCell
        
        if searching {
            cell.breedName.text = searchBreeds[indexPath.row].name
            cell.breedDescription.text = searchBreeds[indexPath.row].temperament
            cell.breedDescription.isEditable = false
        }
        else {
            cell.breedName.text = breeds[indexPath.row].name
            cell.breedDescription.text = breeds[indexPath.row].temperament
            cell.breedDescription.isEditable = false
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BreedViewController{
            if searching {
                destination.breed = self.searchBreeds[tableView.indexPathForSelectedRow?.row ?? 0]
            }
            else {
                destination.breed = self.breeds[tableView.indexPathForSelectedRow?.row ?? 0]
            }
        }
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
