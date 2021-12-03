//
//  BeerListViewMock.swift
//  BeerChallengeTests
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation
@testable import BeerChallenge

class BeerListViewMock: NSObject, BeerListViewProtocol {
    var renderStateCalled = false
    var errorStateCalled = false
    
    func changeState(_ state: BeerListStates) {
        switch state {
        case .render:
            renderStateCalled = true
        case .error:
            errorStateCalled = true
        default:
            break
        }
    }
}
