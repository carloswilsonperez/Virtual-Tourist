//
//  photoViewCell.swift
//  VirtualTourist
//
//  Created by 강선미 on 27/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit

class photoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    func initPhotoCell() {
        setActivityIndicator(true)
        
        
        
    }
    

    func setActivityIndicator(_ flag: Bool) {
        if flag {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}


