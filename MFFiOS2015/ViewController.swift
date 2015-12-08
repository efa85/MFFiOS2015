//
//  ViewController.swift
//  MFFiOS2015
//
//  Created by Fernandez Astigarraga Emilio on 01/12/15.
//  Copyright © 2015 avast. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let reverseCountryGeocoder = ReverseCountryGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = NSLocalizedString("mapScreen.title", value: "MFF Map", comment: "Map screen title")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mapViewTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(mapView)
        let coordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
        
        addAnnotationForCoordinate(coordinate)
        
        reverseCountryGeocoder.reverseGeocodeCountryWithCoordinate(coordinate) { [weak self] (result) -> Void in
            self?.handleReverseCountryGeocoderResult(result)
        }
    }
    
    private func handleReverseCountryGeocoderResult(result: ReverseCountryGeocoderResult) {
        switch result {
            case .Success(let country):
                showAppsForCountry(country)
            case .Failure(let error):
                showError(error)
        }
    }
    
    private func showAppsForCountry(country: String) {
        print(country)
        // TODO:
    }
    
    private func showError(error: NSError) {
        // TODO:
    }
    
    private func addAnnotationForCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
    }

}
