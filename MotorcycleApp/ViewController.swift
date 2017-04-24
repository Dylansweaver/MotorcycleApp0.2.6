//
//  ViewController.swift
//  MotorcycleApp
//
//  Created by Dylan Sebastian Weaver on 3/13/17.
//  Copyright © 2017 Dylan Sebastian Weaver. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

   
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    let locationManager = CLLocationManager()
    var searchingText = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
           // self.locationManager.stopUpdatingLocation()
        //})
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        
    }
    
    
  
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func myLocation(_ sender: UIButton) {
        DispatchQueue.main.async {
            
            self.locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.locationManager.stopUpdatingLocation()
            })
           
            
        }
    }
    
    @IBAction func textFieldReturn(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        searchingText = textSearch.text!
        self.performSearch()
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        
            
            
        }
    }
    @IBAction func gasStationButton(_ sender: UIBarButtonItem) {
        mapView.removeAnnotations(mapView.annotations)
        searchingText = "Gas"
        self.performSearch()

    }
     func performSearch() {
      
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
    
        request.naturalLanguageQuery = searchingText
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
    
    

    @IBAction func gesture(_ sender: Any) {
    self.locationManager.stopUpdatingLocation()
    }
    
}
