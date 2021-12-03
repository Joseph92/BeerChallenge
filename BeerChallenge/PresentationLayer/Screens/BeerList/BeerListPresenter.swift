//
//  BeerListPresenter.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import Foundation

enum BeerListStates {
    case clear
    case render(viewModel: [BeerViewModel])
    case error
}

protocol BeerListPresenterProtocol: NSObject {
    var view: BeerListViewProtocol? { get set }
    var coordinator: BeerListCoordinator? { get set }
    
    func viewLoaded()
    func openNewsDetail(index: Int)
    func searchByQuery(_ query: String?)
}

final class BeerListPresenter: NSObject, BeerListPresenterProtocol {
    weak var view: BeerListViewProtocol?
    weak var coordinator: BeerListCoordinator?
    
    private var state: BeerListStates = .clear {
        didSet {
            view?.changeState(state)
        }
    }
    
    private let getNewsListUseCase: GetBeerListUseCaseProtocol
    private var models = [BeerModel]()
    
    init(getNewsListUseCase: GetBeerListUseCaseProtocol) {
        self.getNewsListUseCase = getNewsListUseCase
    }
    
    func viewLoaded() {
        fetchNewsList()
    }
    
    func openNewsDetail(index: Int) {
        coordinator?.toBeerDetail(model: models[index])
    }
    
    func searchByQuery(_ query: String?) {
        fetchNewsList(query: query)
    }
}

private extension BeerListPresenter {
    func fetchNewsList(query: String? = nil) {
        state = .clear
        getNewsListUseCase.run(query: query) { [weak self] result in
            switch result {
            case let .success(model):
                self?.models = model
                let viewModel = model.compactMap { self?.buildNewsListViewModel(model: $0) }
                self?.state = .render(viewModel: viewModel)
            case .failure:
                self?.state = .error
            }
        }
    }
    
    func buildNewsListViewModel(model: BeerModel) -> BeerViewModel {
        return .init(title: model.name,
                     subTitle: model.tagline,
                     releaseDate: model.firstBrewedDate,
                     image: model.image)
    }
}
