//
//  MapViewController.swift
//  BottleRocketAssignement
//
//  Created by Hassan baraka on 05/05/21.
//
//


import UIKit
import MapKit
class MapViewController: UIViewController {
    
    @IBOutlet private var mapView: MKMapView!
    
    var resturantsArray:[Restaurant?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var locations = [MKPointAnnotation]()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        self.mapView.setRegion(region, animated: true)
        for item in resturantsArray {
            let lat = item?.location?.lat
            let lon = item?.location?.lng
            let name = item?.name
            
            let coord = CLLocationCoordinate2D(latitude: lat!,longitude: lon!)
            print(coord as Any)
            
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = coord
            dropPin.title = name
            self.mapView.addAnnotation(dropPin)
            self.mapView.selectAnnotation( dropPin, animated: true)
            
            locations.append(dropPin)
            //add this if you want to show them all
            self.mapView.showAnnotations(locations, animated: true)
            
        }
        
    }
    
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 60
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

