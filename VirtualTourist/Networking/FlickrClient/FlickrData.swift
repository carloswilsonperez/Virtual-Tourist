//
//  FlickrData.swift
//  Virtual Tourist
//
//  Created by 강선미 on 22/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

/// The response data returned from the flickr API.
struct FlickrSearchResponseData: Codable {
    let data: FlickrSearchData
    let status: String

    enum CodingKeys: String, CodingKey {
        case data = "photos"
        case status = "stat"
    }
}

/// The search response data returned from the flickr API.
struct FlickrSearchData: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let totalPhotoCount: String
    let photos: [FlickrImage]

    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perPage = "perpage"
        case totalPhotoCount = "total"
        case photos = "photo"
    }
}

/// The image data returned from the flickr API
struct FlickrImage: Codable {
    let id: String
    let title: String
    let mediumUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case mediumUrl = "url_m"
    }
}
