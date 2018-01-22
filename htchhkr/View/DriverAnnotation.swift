//
//  DriverAnnotation.swift
//  htchhkr
//
//  Created by Spencer Yang on 1/22/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import Foundation
import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
    
    // Update annotation of DriverAnnotation when driver is moving with animation
    func update(annotationPosition annotation: DriverAnnotation, coordinate: CLLocationCoordinate2D) {
        var location = self.coordinate
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        UIView.animate(withDuration: 0.2) {
            self.coordinate = location
        }
    }
}
