//
//  ViewController.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    let provider = MoyaProvider<DogService>()
    var allBreeds: BreedsResponse?
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.provider.request(.listBreeds) { (result) in
                switch result {
                case .success(let moyaResponse):
                    let data = moyaResponse.data
                    let decoder = JSONDecoder()
                    do {
                        _ = try moyaResponse.filterSuccessfulStatusAndRedirectCodes()
                        let breedsResponse = try decoder.decode(BreedsResponse.self, from: data)
                        self?.allBreeds = breedsResponse
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

