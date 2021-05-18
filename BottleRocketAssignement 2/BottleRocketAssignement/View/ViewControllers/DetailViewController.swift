//
//  DetailViewController.swift
//  BottleRocketAssignement
//
//  Created by Hassan baraka on 4/14/21.
//

import UIKit
import MapKit
class DetailViewController: UIViewController {
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var resturantNameLabel: UILabel!
    @IBOutlet weak var categoryTypeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!
    var resturantInfo:Restaurant?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resturantInfo as Any)
        print(resturantInfo?.location as Any)
        let lat = resturantInfo?.location?.lat
        let lon = resturantInfo?.location?.lng
        let initialLocation = CLLocation(latitude: lat!, longitude: lon!)
        resturantNameLabel.text = resturantInfo?.name
        categoryTypeLabel.text = resturantInfo?.category
        addressLabel.text = resturantInfo?.location?.address
        phoneNumberLabel.text = resturantInfo?.contact?.phone
        mapView.centerToLocation(initialLocation)
        guard case twitterLabel.text = "@" + (resturantInfo?.contact?.twitter ?? "") else {
            return
        }
       
    }

}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 100
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
