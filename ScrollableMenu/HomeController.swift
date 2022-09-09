//
//  HomeController.swift
//  ScrollableMenu
//
//  Created by Saleh Masum on 7/9/2022.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    
    let menubar = Menubar()
    let playlistCellId = "playlist-cell-id"
    
    let music: [[Track]] = [playlists, artists, albums]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PlaylistCell.self, forCellWithReuseIdentifier: playlistCellId)
        cv.isPagingEnabled = true
        cv.backgroundColor = .spotifyBlack
        cv.dataSource = self
        cv.delegate  = self
        return cv
    }()
    
    let colors: [UIColor] = [.systemMint, .systemGray, .systemCyan]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .spotifyBlack
        menubar.delegate = self
        layout()
    }
    
    func layout() {
        view.addSubview(menubar)
        view.addSubview(collectionView)
        menubar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //menubar
            menubar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menubar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menubar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menubar.heightAnchor.constraint(equalToConstant: 42),
            //collection view
            collectionView.topAnchor.constraint(equalTo: menubar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return music.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: playlistCellId,
                for: indexPath
            )as? PlaylistCell
        else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = colors[indexPath.item]
        cell.tracks = music[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        menubar.selectItem(at: Int(index))
    }
    
}

extension HomeController: MenubarDelegate {
    func didSelectItemAt(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
