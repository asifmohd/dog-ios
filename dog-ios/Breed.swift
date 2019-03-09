//
//  Breed.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import Foundation

struct BreedsResponse: Codable {
    let status: String
    let message: [String: [String]]
}
