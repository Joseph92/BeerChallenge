//
//  BeerDetailBuilder.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

//Builder Pattern
protocol BeerDetailBuilderProtocol {
    func build(model: BeerModel, coordinator: BeerDetailCoordinator) -> BeerDetailViewController
}

final class BeerDetailBuilder: BeerDetailBuilderProtocol {
    func build(model: BeerModel, coordinator: BeerDetailCoordinator) -> BeerDetailViewController {
        // Inject Dependencies
        let vc = BeerDetailViewController()
        let presenter = BeerDetailPresenter(model: model)
        presenter.view = vc
        presenter.coordinator = coordinator
        vc.presenter = presenter
        return vc
    }
}
