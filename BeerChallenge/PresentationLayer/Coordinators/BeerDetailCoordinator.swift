//
//  BeerDetailCoordinator.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation
import UIKit

final class BeerDetailCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childs: [Coordinator] = []
    private let model: BeerModel
    
    init(rootViewController: UINavigationController, model: BeerModel) {
        self.rootViewController = rootViewController
        self.model = model
    }
    
    func start() {
        let vc = BeerDetailBuilder().build(model: model,coordinator: self)
        rootViewController.pushViewController(vc, animated: true)
    }
}
