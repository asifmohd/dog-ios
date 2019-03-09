//
//  DogService.swift
//  dog-ios
//
//  Created by Asif on 09/03/19.
//  Copyright © 2019 Asif. All rights reserved.
//

import Foundation
import Moya

enum DogService {
    case listBreeds
}

extension DogService: TargetType {
    var baseURL: URL { return URL(string: "https://dog.ceo/api")! }

    var path: String {
        switch self {
        case .listBreeds:
            return "/breeds/list/all"
        }
    }

    var method: Moya.Method {
        switch self {
        case .listBreeds:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .listBreeds:
            return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .listBreeds:
            return """
{
"status": "success",
"message": {
"affenpinscher": [],
"african": [],
"airedale": [],
"akita": [],
"appenzeller": [],
"basenji": [],
"beagle": [],
"bluetick": [],
"borzoi": [],
"bouvier": [],
"boxer": [],
"brabancon": [],
"briard": [],
"bulldog": [
"boston",
"french"
]
}
}
""".data(using: .utf8)!
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
