//
//  BreedListTableViewCell.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import UIKit

class BreedListTableViewCell: UITableViewCell {
    @IBOutlet weak var breedNameLabel: UILabel!

    static var ReuseIdentifier: String {
        return String(describing: self)
    }
}
