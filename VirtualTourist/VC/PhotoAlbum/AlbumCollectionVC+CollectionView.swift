//
//  AlbumCollectionVC+CollectionView.swift
//  VirtualTourist
//
//  Created by 강선미 on 26/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import UIKit
extension AlbumCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        let sections = fetchedResultsController.sections ?? []
//
//        return sections.isEmpty ? 0 : 1
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return count
    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier, for: indexPath as IndexPath) as! PhotoViewCell
       let imageName = String("image\(indexPath.row + 1).png")
       cell.photoImageView.image = UIImage(named: imageName)
       cell.checkMarkView.style = .grayedOut
       cell.checkMarkView.setNeedsDisplay()
       
        return cell
    }
    
    /// Set up the Collection View.
    func setUpCollectionView() {
        // Set up Collection View
        collectionView.dataSource = self
        collectionView.delegate = self
        configureFlowLayout()
    }

    /// Set up the flow layout for the Collection View.
    func configureFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellSideLength = (collectionView.frame.width/3) - 1
            flowLayout.itemSize = CGSize(width: cellSideLength, height: cellSideLength)
        }
    }
}
