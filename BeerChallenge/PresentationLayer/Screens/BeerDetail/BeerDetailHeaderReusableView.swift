//
//  BeerDetailHeaderReusableView.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import UIKit

final class BeerDetailHeaderReusableView: UICollectionReusableView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bgShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 3
        title.textColor = .white
        title.font = .systemFont(ofSize: 18, weight: .bold)
        return title
    }()
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.numberOfLines = 1
        date.textColor = .white
        date.font = .systemFont(ofSize: 12, weight: .light)
        return date
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has nor been implemented")
    }
    
    deinit {
        imageView.sd_cancelCurrentImageLoad()
    }
    
    func setup(viewModel: BeerDetailViewModel?) {
        guard let viewModel = viewModel else { return }
        imageView.sd_setImage(with: viewModel.image, placeholderImage: #imageLiteral(resourceName: "noimage"))
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.releaseDate
    }
}

private extension BeerDetailHeaderReusableView {
    func setupUI() {
        backgroundColor = .clear
        clipsToBounds = true
        setupImageView()
        setupBgShadowView()
        setupDateLabel()
        setupTitleLabel()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupBgShadowView() {
        addSubview(bgShadowView)
        bgShadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgShadowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bgShadowView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bgShadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
