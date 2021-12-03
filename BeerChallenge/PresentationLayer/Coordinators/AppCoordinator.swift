//
//  AppCoordinator.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childs: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let coordinator = BeerListCoordinator(rootViewController: rootViewController)
        coordinator.start()
        childs.append(coordinator)
    }
}
