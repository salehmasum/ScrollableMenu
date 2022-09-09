//
//  PlaylistCell.swift
//  ScrollableMenu
//
//  Created by Saleh Masum on 7/9/2022.
//

import UIKit

class PlaylistCell: UICollectionViewCell {
    
    let trackCellId = "trackId"
    var tracks: [Track]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: trackCellId)
        cv.backgroundColor = .spotifyBlack
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension PlaylistCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tracks = tracks else { return 0 }
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackCellId, for: indexPath) as? TrackCollectionViewCell else { return UICollectionViewCell() }
        cell.track = tracks?[indexPath.item]
        return cell
    }
}

extension PlaylistCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: trackCellHeight)
    }
}


struct Track {
    let imageName: String
    let title: String
    let artist: String
}
