//
//  BeerProviderTests.swift
//  BeerChallengeTests
//
//  Created by Josseph Colonia on 2/12/21.
//

import XCTest
@testable import BeerChallenge

class BeerProviderTests: XCTestCase {
    var provider: BeerProvider! //sut
    
    override func setUp() {
        provider = BeerProvider()
    }
    
    func testGetBeerList() {
        // When
        let exp = expectation(description: "testGetBeerList")
        var response: [BeerEntity]?
        provider.getBeerList(query: nil) { result in
            switch result {
            case .success(let resp):
                response = resp
                exp.fulfill()
            case .failure:
                break
            }
        }
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertNotNil(response)
    }
}
