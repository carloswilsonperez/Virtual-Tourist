
//  FlickrData.swift
//  Virtual Tourist
//
//  Created by 강선미 on 29/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

/// The response data returned from the flickr API.
struct PhotoResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [PhotoStruct]
}
