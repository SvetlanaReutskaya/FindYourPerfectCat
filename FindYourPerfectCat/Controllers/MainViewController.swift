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
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickStartButton(sender: AnyObject){
        let storyboard = UIStoryboard(name: "TableView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableView") as UIViewController
        present(vc, animated: true, completion: nil)
    }

}

