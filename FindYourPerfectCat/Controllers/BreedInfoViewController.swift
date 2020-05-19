//
//  BreedInfoViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 17.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class BreedInfoViewController: UIViewController {

    @IBOutlet weak var breedPhoto: UIImageView!
    
    @IBOutlet weak var breedText: UITextView!
    
    @IBOutlet weak var breedTitle: UILabel!
    
    var breed: Breed?
    var breedImg: BreedImg?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        breedTitle.text = breed?.name
        breedText.text = breed?.description
        downloadJSONImage{
            self.breedPhoto.downloaded(from: self.breedImg!.url)
        }
    }
    
    func downloadJSONImage(completed: @escaping() -> ()){
        let url = NSURL(string: "https://api.thecatapi.com/v1/images/search?breed_id=" + breed!.id)
    
        var request = URLRequest(url: url! as URL)
        request.addValue("2129fafd-26c9-4517-abe3-2ee5a4cfb3f9", forHTTPHeaderField: "x-api-key")
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
