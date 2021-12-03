//
//  BeerListCoordinator.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation
import UIKit

final class BeerListCoordinator: NSObject, Coordinator {
    var rootViewController: UINavigationController
    var childs: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = BeerListBuilder().build(coordinator: self)
        rootViewController.pushViewController(vc, animated: false)
    }
    
    func toBeerDetail(model: BeerModel) {
        rootViewController.delegate = self
        let coordinator = BeerDetailCoordinator(rootViewController: rootViewController, model: model)
        childs.append(coordinator)
        coordinator.start()
    }
}

// Verify if the current VC comes from a child VC for removing of the childs array
extension BeerListCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
        if let newsDetailVC = fromVC as? BeerDetailViewController {
            childDidFinish(newsDetailVC.presenter?.coordinator)
        }
    }
}
