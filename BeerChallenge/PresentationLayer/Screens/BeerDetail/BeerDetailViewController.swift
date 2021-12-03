//
//  BeerDetailViewController.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import UIKit

protocol BeerDetailViewProtocol: NSObject {
    func changeState(_ state: BeerDetailStates)
}

final class BeerDetailViewController: UIViewController {
    var presenter: BeerDetailPresenterProtocol?
    private var news: BeerDetailViewModel?
    
    private lazy var collectionView: UICollectionView = {
        let layout = StretchyHeaderLayout()
        layout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: .zero)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setupUI()
        view.backgroundColor = .white
        title = "Detail"
    }
}

private extension BeerDetailViewController {
    func setupUI() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.register(BeerDetailCollectionViewCell.self, forCellWithReuseIdentifier: "NewsDetailCollectionViewCell")
        collectionView.register(BeerDetailHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BeerDetailHeaderReusableView")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension BeerDetailViewController: BeerDetailViewProtocol {
    func changeState(_ state: BeerDetailStates) {
        switch state {
        case .clear:
            break
        case let .render(news):
            self.news = news
            collectionView.reloadData()
        case .error:
            break
        }
    }
}

extension BeerDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news != nil ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsDetailCollectionViewCell",
                                                            for: indexPath) as? BeerDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel: news)
        return cell
    }
}

extension BeerDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: "BeerDetailHeaderReusableView",
                                                                     for: indexPath) as! BeerDetailHeaderReusableView
        header.setup(viewModel: news)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
}
