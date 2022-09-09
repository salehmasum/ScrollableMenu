//
//  TrackCollectionViewCell.swift
//  ScrollableMenu
//
//  Created by Saleh Masum on 8/9/2022.
//

import UIKit

let trackCellHeight: CGFloat = 72

class TrackCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    
    var track: Track? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")
            imageView.image = image
            titleLabel.text = track.title
            subTitleLabel.text = track.artist
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body).withTraits(traits: .traitBold)
        subTitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subTitleLabel.alpha = 0.7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = makeStackView(axis: .vertical)
        stackView.spacing = 6
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        
        addSubview(imageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: trackCellHeight),
            imageView.widthAnchor.constraint(equalToConstant: trackCellHeight),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3)
        ])
    }
    
}

