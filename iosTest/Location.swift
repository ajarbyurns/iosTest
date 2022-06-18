//
//  Location.swift
//  iosTest
//
//  Created by bitocto_Barry on 18/06/22.
//

import Foundation
import MapKit

class Location : NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var latitude : Double
    var longitude : Double
    var title: String?
    var subtitle: String?
    var id: Int
    
    init(_ lat : Double, _ long : Double, _ identity : Int){
        latitude = lat
        longitude = long
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        title = ""
        subtitle = ""
        id = identity
        super.init()
    }
}
