//
//  NewsListPresenterTests.swift
//  BeerChallengeTests
//
//  Created by Josseph Colonia on 2/12/21.
//

import XCTest
@testable import BeerChallenge

class NewsListPresenterTests: XCTestCase {
    var presenter: BeerListPresenter! //SUT
    var getBeerListUseCaseMock: GetBeerListUseCaseMock! // MOCK
    var viewMock: BeerListViewMock! // MOCK
    
    override func setUp() {
        viewMock = BeerListViewMock()
        getBeerListUseCaseMock = GetBeerListUseCaseMock()
        presenter = BeerListPresenter(getNewsListUseCase: getBeerListUseCaseMock)
        presenter.view = viewMock
        viewMock.renderStateCalled = false
        viewMock.errorStateCalled = false
    }
    
    func testFetchDataSuccess() {
        // Given
        let model = getModel()
        getBeerListUseCaseMock.result = .success(model)
        // When
        presenter.viewLoaded()
        // Then
        XCTAssertTrue(viewMock.renderStateCalled)
    }
    
    func testFetchDataFailure() {
        // Given
        let error = NSError(domain: "API.ERROR.500", code: 500, userInfo: nil)
        getBeerListUseCaseMock.result = .failure(error)
        // When
        presenter.viewLoaded()
        // Then
        XCTAssertTrue(viewMock.errorStateCalled)
    }
}

private extension NewsListPresenterTests {
    func getModel() -> [BeerModel] {
        let model = BeerModel(id: 123,
                              name: "Beear",
                              tagline: "The Best Beer",
                              firstBrewedDate: "10/2019",
                              image: nil,
                              description: "",
                              foodPairing: [])
        return [model, model]
    }
}
