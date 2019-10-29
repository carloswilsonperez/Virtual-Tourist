//
//  PhotoViewCell.swift
//  VirtualTourist
//
//  Created by 강선미 on 27/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData

class PhotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var checkMarkView: CheckMarkView!
    
    static let reuseIdentifier = "Cell"
    

    func setPhotoImageView(imageView: UIImage, sizeFit: Bool) {
        photoImageView.image = imageView
        if sizeFit == true {
            photoImageView.sizeToFit()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = UIImage()
        self.activityIndicator.startAnimating()
    }
    
    
}


