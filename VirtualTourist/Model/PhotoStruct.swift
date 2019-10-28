//
//  Photo.swift
//  VirtualTourist
//
//  Created by 강선미 on 28/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Photo
struct PhotoStruct: Codable {
    var photoImage: UIImage?
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let urlM: String
//    let heightM, widthM: String
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlM = "url_m"
//        case heightM = "height_m"
//        case widthM = "width_m"
    }
}
