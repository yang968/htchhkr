//
//  PassengerAnnotation.swift
//  htchhkr
//
//  Created by Spencer Yang on 2/10/18.
//  Copyright © 2018 Seungho Yang. All rights reserved.
//

import UIKit
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate : CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
