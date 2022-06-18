//
//  MapViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit
import MapKit
import FittedSheets

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let reuseId = "Annotation"
    var users : [User] = []
    var annotations : [Location] = []
    
    let maxLongitude : Double = 140
    let minLongitude : Double = 100
    let maxLatitude : Double = 15
    let minLatitude : Double = -7
    
    weak var controller : BottomSheetViewController? = nil
    var sheetController : SheetViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        controller = storyboard?.instantiateViewController(withIdentifier: "Bottom") as? BottomSheetViewController
        controller?.parentVC = self
        let options = SheetOptions(
            useInlineMode: true
        )
        sheetController = SheetViewController(controller: controller ?? UIViewController(), sizes: [.percent(0.4), .fullscreen], options: options)
        sheetController?.allowGestureThroughOverlay = true
        sheetController?.dismissOnOverlayTap = true
        sheetController?.dismissOnPull = true
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
            if let sc = sheetController {
                sc.animateIn(to: self.view, in: self)
                //navigationController?.present(sc, animated: true, completion: nil)
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

extension MKMapView {
  func centerToLocation(_ location: Location) {
      let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: span)
      setRegion(coordinateRegion, animated: true)
      //setCenter(location.coordinate, animated: true)
  }
    
    func centerToLocation(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        setRegion(coordinateRegion, animated: true)
        //setCenter(coordinate, animated: true)
    }
}
