//
//  RepositoriesServiceTest.swift
//  GithubReposSearcherTests
//
//  Created by Viktor Drykin on 24.07.2024.
//

import XCTest
@testable import GithubReposSearcher

final class RepositoriesServiceTest: XCTestCase {

    var sut: RepositoriesServiceImpl!
    var apiServiceStub: APIServiceStub!

    override func setUpWithError() throws {
        apiServiceStub = APIServiceStub()
        sut = .init(apiService: apiServiceStub)
    }

    func test_fetchRepos_serviceReturnsListOrRepositoriesWhenAPIReturnsThem() async throws {
        let expectedResult = RepositoryDTO(id: 0, name: "name", description: "decription", url: nil)
        apiServiceStub.result = .success([expectedResult])
        let repositories = try await sut.fetchRepos(with: "Apple")
        XCTAssertEqual(repositories.count, 1)
        XCTAssertEqual(repositories[0].id, expectedResult.id)
        XCTAssertEqual(repositories[0].description, expectedResult.description)
        XCTAssertEqual(repositories[0].name, expectedResult.name)
        XCTAssertEqual(repositories[0].url, expectedResult.url)
    }

    func test_fetchRepos_whenAPIReturnsEmptyListOfRepositories_thenServiceReturnsEmptyListError() async throws {
        apiServiceStub.result = .success([RepositoryDTO]())

        do {
            let _ = try await sut.fetchRepos(with: "Apple")
            XCTFail("Unexpected result")
        } catch {
            XCTAssertEqual(error as? RepositoryServiceError, RepositoryServiceError.empty)
        }
    }

    func test_fetchRepos_whenAPIreturnsInvalidStatusCode_thenServiceMapErrorProperly() async throws {
        apiServiceStub.result = .failure(NetworkError.invalidStatusCode)

        do {
            let _ = try await sut.fetchRepos(with: "user")
            XCTFail("Unexpected result")
        } catch {
            XCTAssertEqual(error as? RepositoryServiceError, RepositoryServiceError.invalidStatusCode)
        }
    }

    func test_fetchRepos_whenAPIreturnsFailedToDecode_thenServiceMapErrorProperly() async throws {
        apiServiceStub.result = .failure(NetworkError.failedToDecode)

        do {
            let _ = try await sut.fetchRepos(with: "user")
            XCTFail("Unexpected result")
        } catch {
            XCTAssertEqual(error as? RepositoryServiceError, RepositoryServiceError.failedToDecode)
        }
    }

    func test_fetchRepos_whenUserIsEmptyString_thenServiceReturnsIncorrectURLError() async throws {
        apiServiceStub.result = .failure(NetworkError.failedToDecode)

        do {
            let _ = try await sut.fetchRepos(with: "")
            XCTFail("Unexpected result")
        } catch {
            XCTAssertEqual(error as? RepositoryServiceError, RepositoryServiceError.incorrectURL)
        }
    }
}
