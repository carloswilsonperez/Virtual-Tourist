//
//  Location.swift
//  VirtualTourist
//
//  Created by 강선미 on 24/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let location: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case location, country, latitude, longitude
    }
}
