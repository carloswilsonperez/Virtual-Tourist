//
//  FlickrDataProtocol.swift
//  Virtual Tourist
//
//  Created by 강선미 on 22/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import UIKit

/// Connect with Flickr's API

class FlickrClient {
    /// get photos from Flickr for a specific pin
    /// - Param.
    ///   - pin:
    func getFlickrPhotos(fromPin pin: Pin, totalPage page: Int, completion: @escaping (Pin?, Int?, Error?) -> Void) {
      //  let pin = pin.objectID
        
        
    }
    
    func getPinImages(fromPin pin: Pin, totalPage page: Int, completion: @escaping (FlickrSearchData?, Error?) -> Void) {
        let parameter = [
            ParamKeys.APIKey: ParamDefaultValue.APIKey,
            ParamKeys.Format: ParamDefaultValue.Format,
            ParamKeys.NoJsonCallback: ParamDefaultValue.NoJsonCallback,
            ParamKeys.Method: Methods.PhotosSearch,
            ParamKeys.Extra: ParamDefaultValue.ExtraMediumURL,
            ParamKeys.Page: String(page),
            ParamKeys.RadiusUnits: ParamDefaultValue.RadiusUnits,
            ParamKeys.Radius: ParamDefaultValue.Radius,
            ParamKeys.ResultsPerPage: ParamDefaultValue.ResultsPerPage,

        
        ]
        
        
        
    }
    
}
