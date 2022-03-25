//
//  MapView.swift
//  Mkmap-in-SwiftUI
//
//  Created by Colantonio Raffaele on 24/03/22.
//

import Foundation
import SwiftUI
import MapKit

//    Create a struct that comforms to "UIViewRepresentable", an Unwrap of UIKIT component that can communicate with SwiftUI view
struct MapView: UIViewRepresentable {

//    create a var to reclaim your data
var forDisplay = data
//    set the principal region coordinate
//    in this case we have some coordinates of some locations in Naples
@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.64422936785126, longitude: 14.39329541313924),
    span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 2)
)

//now we need to create this Coordinator to communicate with SwiftUI View
class Coordinator: NSObject, MKMapViewDelegate {
    
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }
    
// showing annotation on the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? LandmarkAnnotation else { return nil }
        return AnnotationView(annotation: annotation, reuseIdentifier: AnnotationView.ReuseID)
    }

}


//we need to add a new method called makeCoordinator(), which will automatically be called by SwiftUI if we implement it. All that it needs to do is to create and configure an instance of our Coordinator class, then send it back.
//    We don’t call makeCoordinator() ourselves, SwiftUI calls it automatically when an instance is created.
func makeCoordinator() -> Coordinator {
    MapView.Coordinator(self)
}

//giving it makeUiView() method that will return our MKMapView
func makeUIView(context: Context) -> MKMapView {
    //  create a map
    let view = MKMapView()
    // connecting delegate with the map
    view.delegate = context.coordinator
    view.setRegion(region, animated: false)
    view.mapType = .standard
//    making points visible on the map
    for points in forDisplay {
        let annotation = LandmarkAnnotation(coordinate: points.coordinate)
        view.addAnnotation(annotation)
    }
    
// return the view of the function
    return view
    
}
//Adding an updateUIView() method that will be called whenever the text data view has changed.
func updateUIView(_ uiView: MKMapView, context: Context) {
    
}
}
//This is our struct with method identifiable to give an id to our data
struct CoordinateData: Identifiable {
var id = UUID()
var latitude: Double
var longitude: Double
var coordinate: CLLocationCoordinate2D {
CLLocationCoordinate2D(
    latitude: latitude,
    longitude: longitude)
 }
}
//our data
var data = [
CoordinateData(latitude: 40.70564024126748, longitude: 14.37968945214223),
CoordinateData(latitude: 40.81257464206404, longitude: 14.82112322464369),
CoordinateData(latitude: 41.38416585162576, longitude: 14.7252598737476),
CoordinateData(latitude: 40.29168643283501, longitude: 14.95286751470724),
CoordinateData(latitude: 41.49261392585982, longitude: 14.9343973160499),
CoordinateData(latitude: 40.69825427301145, longitude: 14.91227845284203)
]

//Create this LandmarkAnnotation to set CLLocationCoordinate2D and initialiaze it
class LandmarkAnnotation: NSObject, MKAnnotation {
let coordinate: CLLocationCoordinate2D
init(
     coordinate: CLLocationCoordinate2D
) {
    self.coordinate = coordinate
    super.init()
}
}


// here it is possible to customize AnnotationView
let clusterID = "clustering"

class AnnotationView: MKMarkerAnnotationView {

static let ReuseID = "cultureAnnotation"

// setting the key for clustering annotations
override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    clusteringIdentifier = clusterID
}


required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

override func prepareForDisplay() {
    super.prepareForDisplay()
    displayPriority = .defaultLow
 }
}

