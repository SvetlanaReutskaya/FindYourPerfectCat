//
//  Breed.swift
//  FindYourPerfectCat
//
//  Created by Svetlana on 17.05.2020.
//  Copyright © 2020 Svetlana. All rights reserved.
//

import UIKit

struct Breed: Decodable {
    var id: String
    var name: String
    var temperament: String
    var description: String
    
    var child_friendly: Int
    var dog_friendly: Int
    var energy_level: Int
    var intelligence: Int
    var hypoallergenic: Int
    
    public func breedInfo()->String{
        
        var result = ""
        result += child_friendly > 3 ? "🐾 Child-friendly \n" : ""
        result += dog_friendly > 3 ? "🐾 Dog-friendly \n" : ""
        result += intelligence > 3 ? "🐾 Intelligent \n" : ""
        result += hypoallergenic == 1 ? "🐾 Hypoallergenic \n" : ""
        
        return result;
    }
}
