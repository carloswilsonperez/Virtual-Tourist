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

    // numberOfObjects
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return count
    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       // CollectionView
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier, for: indexPath as IndexPath) as! PhotoViewCell
       
         let cnt = self.fetchedResultsController.fetchedObjects?.count ?? 0
         guard cnt > 0 else {
            print("images are already present")
            return cell
        }
    
        // fetch core data
        let photoData = self.fetchedResultsController.object(at: indexPath)
   
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        
        
        if photoData.imageData == nil {
            
            // run thread
            DispatchQueue.global(qos: .background).async {
                if let imageData = try? Data(contentsOf: photoData.imageUrl!) {
                    DispatchQueue.main.async {
                        photoData.imageData = imageData
                        do {
                            try self.dataController.viewContext.save()
                            
                        } catch {
                            print("error in saving image data")
                        }
                        
                        let image = UIImage(data: imageData)!
                        print("index is: \(indexPath.row)")
                        cell.setPhotoImageView(imageView: image, sizeFit: true)
         
                    }
                }
        
            }
            
        } else {
          
            let imageData = photoData.imageData!
            let image = UIImage(data: imageData)!
            cell.setPhotoImageView(imageView: image, sizeFit: false)
            
        }
        
        cell.activityIndicator.isHidden = true
        cell.activityIndicator.stopAnimating()
        
        cell.checkMarkView.style = .grayedOut
        cell.checkMarkView.setNeedsDisplay()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! PhotoViewCell
        cell.checkMarkView.checked = !cell.checkMarkView.checked
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
