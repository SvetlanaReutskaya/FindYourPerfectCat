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
    var origin: String
    var description: String
    var life_span: String
    var alt_names: String
    
    var indoor: Int
    var adaplability: Int
    var child_friendly: Int
    var dog_friendly: Int
    var energy_level: Int
    var grooming: Int
    var health_issues: Int
    var intelligence: Int
    var vocalisation: Int
    var hairless: Int
    var suppressed_tail: Int
    var short_legs: Int
    var hypoallergenic: Int
}
