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
    let popularApplicationRetriever = PopularApplicationRetriever()
    var applications: [Application]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = NSLocalizedString("mapScreen.title", value: "MFF Map", comment: "Map screen title")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let applicationsViewController = segue.destinationViewController as? ApplicationsViewController {
            applicationsViewController.applications = applications
        }
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
        case .Success(let countryCode):
            popularApplicationRetriever.retrievePopularApplicationsWithCountryCode(countryCode) { [weak self] (result) -> Void in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self?.handleApplicationRetrieverResult(result)
                }
            }
        case .Failure(let error):
            showError(error)
        }
    }
    
    private func handleApplicationRetrieverResult(result: PopularApplicationRetrieverResult) {
        switch result {
        case .Success(let applications):
            showApplications(applications)
        case .Failure:
            // TODO:
            break
        }
    }
    
    private func showApplications(applications: [Application]) {
        self.applications = applications
        performSegueWithIdentifier("ShowApplications", sender: nil)
    }
    
    private func showError(error: NSError) {
        let title = NSLocalizedString("mapScreen.errorReverseGeocoding.title", value: "Error geocoding", comment: "Reverse geocoder error alert title")
        let message = NSLocalizedString("mapScreen.errorReverseGeocoding.message", value: "Could not reverse geocode the location you selected", comment: "Reverse geocoder error alert message")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let actionTitle = NSLocalizedString("mapScreen.errorReverseGeocoding.buttonText", value: "OK", comment: "Reverse geocoder error alert button text")
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(action)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func addAnnotationForCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
    }

}
