//
//  BeerListViewController.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import UIKit

protocol BeerListViewProtocol: NSObject {
    func changeState(_ state: BeerListStates)
}

final class BeerListViewController: UIViewController {
    var presenter: BeerListPresenterProtocol?
    private var news = [BeerViewModel]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Last News"
        presenter?.viewLoaded()
        setupUI()
    }
}

private extension BeerListViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Beer"
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension BeerListViewController: BeerListViewProtocol {
    func changeState(_ state: BeerListStates) {
        switch state {
        case .clear:
            break
        case let .render(news):
            self.news = news
            tableView.reloadData()
        case .error:
            break
        }
    }
}

extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = news[indexPath.item]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as? BeerTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(viewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openNewsDetail(index: indexPath.item)
    }
}

extension BeerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.searchByQuery(searchController.searchBar.text)
        
    }
}
