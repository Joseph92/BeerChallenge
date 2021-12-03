//
//  BeerTableViewCell.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import UIKit
import SDWebImage

final class BeerTableViewCell: UITableViewCell {
    private lazy var bgImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bgShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textColor = .white
        title.font = .systemFont(ofSize: 20, weight: .bold)
        return title
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textColor = .white
        title.font = .systemFont(ofSize: 14, weight: .medium)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bgImage.sd_cancelCurrentImageLoad()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: BeerViewModel) {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        dateLabel.text = viewModel.releaseDate
        bgImage.sd_setImage(with: viewModel.image, placeholderImage: #imageLiteral(resourceName: "noimage"))
    }
}

private extension BeerTableViewCell {
    func setupUI() {
        backgroundColor = .white
        
        setupBgImage()
        setupBgShadowView()
        setupDateLabel()
        setupTitleLabel()
        setupSubTitleLabel()
    }
    
    func setupBgImage() {
        addSubview(bgImage)
        bgImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        bgImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bgImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupBgShadowView() {
        addSubview(bgShadowView)
        bgShadowView.topAnchor.constraint(equalTo: bgImage.topAnchor).isActive = true
        bgShadowView.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor).isActive = true
        bgShadowView.trailingAnchor.constraint(equalTo: bgImage.trailingAnchor).isActive = true
        bgShadowView.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor).isActive = true
    }
    
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor, constant: 16).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: -16).isActive = true
        
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: bgImage.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: bgImage.trailingAnchor, constant: -16).isActive = true
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setupSubTitleLabel() {
        addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        subTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
