//
//  BeerDetailCollectionViewCell.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import UIKit

final class BeerDetailCollectionViewCell: UICollectionViewCell {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var FoodPairingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Food Pairing:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var widthConstraint: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width - 40)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: BeerDetailViewModel?) {
        descriptionLabel.text = viewModel?.body
        for food in viewModel?.foodPairing ?? [] {
            let label = UILabel()
            label.text = String(format: "◆ %@", food)
            label.font = .systemFont(ofSize: 14, weight: .medium)
            verticalStackView.addArrangedSubview(label)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}

private extension BeerDetailCollectionViewCell {
    func setupUI() {
        backgroundColor = .white
        clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupDescriptionLabel()
        setupFoodPairingTitle()
        setupVerticalStackView()
    }
    
    func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func setupFoodPairingTitle() {
        contentView.addSubview(FoodPairingTitleLabel)
        FoodPairingTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        FoodPairingTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        FoodPairingTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func setupVerticalStackView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.topAnchor.constraint(equalTo: FoodPairingTitleLabel.bottomAnchor, constant: 8.0).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20.0).isActive = true
    }
}
