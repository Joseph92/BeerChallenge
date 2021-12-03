//
//  BeerListBuilder.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

//Builder Pattern
protocol BeerListBuilderProtocol {
    func build(coordinator: BeerListCoordinator) -> BeerListViewController
}

final class BeerListBuilder: BeerListBuilderProtocol {
    func build(coordinator: BeerListCoordinator) -> BeerListViewController {
        // Inject dependencies
        let vc = BeerListViewController()
        let provider = BeerProvider()
        let mapper = BeerMapper()
        let useCase = GetBeerListUseCase(provider: provider, mapper: mapper)
        let presenter = BeerListPresenter(getNewsListUseCase: useCase)
        presenter.view = vc
        presenter.coordinator = coordinator
        vc.presenter = presenter
        return vc
    }
}
