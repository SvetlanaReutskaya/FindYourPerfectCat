//
//  BreedInfoViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 17.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit



class BreedInfoViewController: UIViewController {

    @IBOutlet weak var breedPhoto: UIImageView!
    @IBOutlet weak var breedText: UITextView!
    
    var breed: Breed?
    var breedImg: BreedImg?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        breedText.text = breed?.breedInfo()
        breedText.isEditable = false
        title = breed?.name
        
        downloadJSONImage{
            self.breedPhoto.downloaded(from: self.breedImg!.url)
        }

    }
    
    func downloadJSONImage(completed: @escaping() -> ()){
        let url = NSURL(string: CatApiResources.init().getBreedImg + breed!.id)
    
        var request = URLRequest(url: url! as URL)
        request.addValue(CatApiResources.init().apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            if(error==nil){
                do{
                    self.breedImg = try JSONDecoder().decode([BreedImg].self, from: data!)[0]
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
