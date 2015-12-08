//
//  ReverseGeocode.swift
//  MFFiOS2015
//
//  Created by Fernandez Astigarraga Emilio on 08/12/15.
//  Copyright © 2015 avast. All rights reserved.
//

import MapKit

enum ReverseCountryGeocoderResult {
    case Success(country: String)
    case Failure(error: NSError)
}

let ReverseCountryGeocoderDomain = "ReverseCountryGeocoderDomain"
let ReverseCountryGeocoderNotACountryErrorCode = 0

class ReverseCountryGeocoder {
    
    let geocoder = CLGeocoder()
    
    func reverseGeocodeCountryWithCoordinate(
        coordinate: CLLocationCoordinate2D,
        completion: (ReverseCountryGeocoderResult) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            guard let placemark = placemarks?.first else {
                completion(.Failure(error: error!))
                return
            }
            
            guard let country = placemark.country else {
                let error = NSError(domain: ReverseCountryGeocoderDomain, code: ReverseCountryGeocoderNotACountryErrorCode, userInfo: nil)
                completion(.Failure(error: error))
                return
            }
                
            completion(.Success(country: country))
        }
    }
    
}
