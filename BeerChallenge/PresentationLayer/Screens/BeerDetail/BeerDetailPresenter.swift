//
//  BeerDetailPresenter.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

enum BeerDetailStates {
    case clear
    case render(viewModel: BeerDetailViewModel)
    case error
}

protocol BeerDetailPresenterProtocol: NSObject {
    var view: BeerDetailViewProtocol? { get set }
    var coordinator: BeerDetailCoordinator? { get set }
    
    func viewLoaded()
}

final class BeerDetailPresenter: NSObject, BeerDetailPresenterProtocol {
    weak var view: BeerDetailViewProtocol?
    weak var coordinator: BeerDetailCoordinator?
    
    private var state: BeerDetailStates = .clear {
        didSet {
            view?.changeState(state)
        }
    }
    
    private var model: BeerModel
    
    init(model: BeerModel) {
        self.model = model
    }
    
    func viewLoaded() {
        state = .render(viewModel: self.buildNewsListViewModel(model: model))
    }
}

private extension BeerDetailPresenter {

    func buildNewsListViewModel(model: BeerModel) -> BeerDetailViewModel {
        return .init(title: model.name,
                     header: model.tagline,
                     releaseDate: model.firstBrewedDate,
                     body: model.description,
                     image: model.image,
                     foodPairing: model.foodPairing)
    }
}
