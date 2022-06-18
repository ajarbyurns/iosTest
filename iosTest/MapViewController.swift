//
//  MapViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let reuseId = "Annotation"
    var users : [User] = []
    var annotations : [Location] = []
    
    let maxLongitude : Double = 140
    let minLongitude : Double = 100
    let maxLatitude : Double = 15
    let minLatitude : Double = -7
    
    var controller : BottomSheetViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        controller = storyboard?.instantiateViewController(withIdentifier: "Bottom") as? BottomSheetViewController
        controller?.modalPresentationStyle = .overCurrentContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.removeAnnotations(annotations)
        annotations = []
        for i in 0..<users.count {
            let annotation = Location(Double.random(in: minLatitude...maxLatitude), Double.random(in: minLongitude...maxLongitude), i)
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let location = view.annotation as? Location {
            mapView.setCenter(location.coordinate, animated: true)
            let selectedUser = users[location.id]
            controller?.user = selectedUser
            if let con = controller {
                navigationController?.present(con, animated: true, completion: nil)
            }
        }
        mapView.deselectAnnotation(view.annotation, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView{
            annotationView = dequeuedView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pinpoint")
        }
        return annotationView
    }
}
