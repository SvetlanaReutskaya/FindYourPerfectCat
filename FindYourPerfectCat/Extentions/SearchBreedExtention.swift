//
//  SearchBreedExtention.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 21.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit


extension BreedsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var searchArray = [Breed]()
        let searchT = searchText.trimmingCharacters(in: .whitespaces)
        searchT.split(separator: ",").forEach { str in
            if searchArray.count == 0 {
                searchArray = breeds.filter({$0.temperament.lowercased().contains(str.lowercased())})
            } else {
                searchArray = searchArray.filter({$0.temperament.lowercased().contains(str.lowercased())})
            }
        }
        searchBreeds = searchArray
        
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

extension UIViewController {
    func hideNavigationBar(animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    func showNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
