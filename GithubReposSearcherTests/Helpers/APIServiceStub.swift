//
//  APIServiceStub.swift
//  GithubReposSearcherTests
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation
@testable import GithubReposSearcher

class APIServiceStub: APIServicePerformable {

    var result: Result<Decodable, Error> = .failure(NetworkError.invalidStatusCode)

    func perform<Output: Decodable>(urlRequest: URLRequest) async throws -> Output {
        switch result {
        case .success(let result):
            guard let resultOutput = result as? Output else {
                throw NetworkError.failedToDecode
            }
            return resultOutput
        case .failure(let error):
            throw error
        }
    }
    

}
