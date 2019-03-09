//
//  BreedListViewModel.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import Foundation
import Moya

protocol BreedListViewModelDelegate: class {
    func dataLoaded()
}

class BreedListViewModel {
    private let provider = MoyaProvider<DogService>()
    var breedList: [String] = []
    var breedMap: [String: [String]] = [:]
    weak var delegate: BreedListViewModelDelegate?

    func makeAPICall() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.provider.request(.listBreeds) { (result) in
                switch result {
                case .success(let moyaResponse):
                    let data = moyaResponse.data
                    let decoder = JSONDecoder()
                    do {
                        _ = try moyaResponse.filterSuccessfulStatusAndRedirectCodes()
                        let breedsResponse = try decoder.decode(BreedsResponse.self, from: data)
                        self?.constructDataSource(response: breedsResponse.message)
                        self?.delegate?.dataLoaded()
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func constructDataSource(response: [String: [String]]) {
        self.breedList = response.keys.sorted()
        self.breedMap = response
    }
}
