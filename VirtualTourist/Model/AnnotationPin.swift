//
//  AnnotationPin.swift
//  VirtualTourist
//
//  Created by 강선미 on 25/10/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import MapKit


class AnnotationPin: MKPointAnnotation {
    var pin: Pin

    init(pin: Pin){
        self.pin = pin
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
    }
}
