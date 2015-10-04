//
//  ViewController.swift
//  BabySaver
//
//  Created by angel diaz on 10/3/15.
//  Copyright © 2015 Angel Diaz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()

    var userLong: CLLocationDegrees!
    var userLat: CLLocationDegrees!
    var usersCurrentLocation: CLLocationCoordinate2D!

    
    var latitude:CLLocationDegrees = 33.42001530
    var longitude:CLLocationDegrees = -111.93736790

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var center:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//        var radius:CLLocationDistance = CLLocationDistance(100.0)
//        var identifier:String = "region"
//        
//        var geoRegion:CLCircularRegion = CLCircularRegion(center: center, radius: radius, identifier: identifier)
//        locationManager.startMonitoringForRegion(geoRegion)
        
        // 2
        userLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            print ("services enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            locationManager.pausesLocationUpdatesAutomatically = false
        } else {
            print ("services disabled")
            let alert = UIAlertController(title: "Location needed", message: "Please enable Location Services in settings.", preferredStyle: .Alert)
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okButton)
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    var speed: CLLocationSpeed?
    var moving = true
    var timerRunning = false
    var timer = NSTimer()
    var counter = 0;
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation: CLLocation = locations[0] as CLLocation
        speed = locationManager.location?.speed
        let mph = 2.2369 * speed!
        print("Current speed: \(mph)")
//        speedLabel.text = "\(Int(mph))"
        if (mph > 5)
        {
            moving = true;
            timer.invalidate()
            timerRunning = false
//            timeLabel.text = "0.0"
            counter = 0
        }
        else if (mph < 5 && timerRunning == false)
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
            timerRunning = true
        }
        
        

        
        let span = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        usersCurrentLocation = manager.location?.coordinate
        let theRegion = MKCoordinateRegion(center: usersCurrentLocation, span: span)

//        mainMap.setRegion(theRegion, animated: true)

        

        
    }
    
    func timerFired () {
        counter++
        if counter <= 60 {
//            timeLabel.text = "\(counter)"
        } else {
//            timeLabel.text = "DEAD BABY"
            timer.invalidate()
            counter = 0
            timerRunning = false
        }
    }

}

