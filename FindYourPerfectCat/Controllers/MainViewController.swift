//
//  ViewController.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 16.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openBreeds(_ sender: Any) {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newController = sb.instantiateViewController(identifier: "BreedsVC") as! CatBreedsViewController
        self.present(newController, animated: true, completion: nil)
    }
    
}

