//
//  BreedListViewModel.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import Foundation
import Moya
import RealmSwift

protocol BreedListViewModelDelegate: class {
    func dataLoaded()
}

class BreedListViewModel {
    private let provider = MoyaProvider<DogService>()
    var breedList: [Breed] = []
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
                        let realm = try Realm()
                        for breed in breedsResponse.message.keys.sorted() {
                            if realm.objects(Breed.self).filter("name == %@", breed).first != nil {
                                continue
                            }
                            let breedObj = Breed()
                            breedObj.name = breed
                            breedObj.subBreeds.append(objectsIn: breedsResponse.message[breed] ?? [])
                            try realm.write {
                                realm.add(breedObj)
                            }
                        }
                        self?.constructDataSource()
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

    func constructDataSource() {
        do {
            let realm = try Realm()
            self.breedList = realm.objects(Breed.self).sorted(byKeyPath: "name").map({$0})
        } catch let error {
            print(error)
        }
    }
}
