//
//  Breed.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import Foundation
import RealmSwift

struct BreedsResponse: Codable {
    let status: String
    let message: [String: [String]]
}

class Breed: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var isFavorite: Bool = false
    let subBreeds: List<String> = List<String>()

    override static func primaryKey() -> String? {
        return "name"
    }
}
