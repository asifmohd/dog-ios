//
//  BreedListViewController.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import UIKit

class BreedListViewController: UIViewController {

    let vm = BreedListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vm.makeAPICall()
    }
}

