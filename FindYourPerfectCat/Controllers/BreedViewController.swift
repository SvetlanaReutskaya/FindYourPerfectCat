//
//  BreedInfoViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 17.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit



class BreedViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var breedText: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var characterTraits: UITextView!
    @IBOutlet weak var likeBtn: UIButton!
    
    var breed: Breed?
    var breedImages = [BreedImg]()
    var frame = CGRect(x:0, y:0, width:0, height:0)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let savedBreeds = defaults.object(forKey: "likedBreeds") as? [String] ?? [String]()
        if savedBreeds.contains(breed!.id) {
            likeBtn.setImage(UIImage(named: "like"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(named: "noLike"), for: .normal)
        }
        breedText.text = breed?.description
        characterTraits.text = breed?.breedInfo()
        breedText.isEditable = false
        title = breed?.name
        
        downloadJSONImage{
            self.setGallery()
        }
    }
    
    
    @IBAction func handleLike(_ sender: Any) {
        setLike()
    }
    
    func setLike(){
        var savedBreeds = defaults.object(forKey: "likedBreeds") as? [String] ?? [String]()
        if savedBreeds.contains(breed!.id) {
            likeBtn.setImage(UIImage(named: "noLike"), for: .normal)
            savedBreeds.removeAll { $0 == breed!.id }
        } else {
            likeBtn.setImage(UIImage(named: "like"), for: .normal)
            savedBreeds.append(breed!.id)
        }
        defaults.set(savedBreeds, forKey: "likedBreeds")
    }
    
    func setGallery(){
        for index in 0..<self.breedImages.count {
            self.frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            self.frame.size = self.scrollView.frame.size
            
            let imgView = UIImageView(frame: self.frame)
            imgView.downloaded(from: self.breedImages[index].url)
            self.scrollView.addSubview(imgView)
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(self.breedImages.count), height: self.scrollView.frame.size.height)
        self.scrollView.delegate = self
    }
    
    func downloadJSONImage(completed: @escaping() -> ()){
        let url = NSURL(string: CatApiResources.init().getBreedImgs + breed!.id)
    
        var request = URLRequest(url: url! as URL)
        request.addValue(CatApiResources.init().apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){(data, response, error) in
            if(error==nil){
                do{
                    self.breedImages = try JSONDecoder().decode([BreedImg].self, from: data!)
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
