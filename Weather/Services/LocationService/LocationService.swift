//
//  LocationService.swift
//  Weather
//
//  Created by Артем Мак on 06.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//
import CoreLocation

class LocationService: NSObject {
    
    static var shared = LocationService()
    private var locationManageer = CLLocationManager()
    private var locationHandler: ((Result<[CLLocation], Error>)-> Void)?
    
    override init() {                                  
        super.init()
        locationManageer.requestWhenInUseAuthorization()
        locationManageer.startUpdatingLocation()
        locationManageer.desiredAccuracy = kCLLocationAccuracyBest
        locationManageer.delegate = self
    }
    
    public func getLocation(completion: @escaping (Result<[CLLocation], Error>)-> Void) {
        self.locationHandler = completion
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            locationHandler?(.failure(NSError(domain: "Locations are missing", code: 1, userInfo: [:])))
            return
        }
        locationHandler?(.success([location]))
        locationManageer.stopUpdatingLocation()
    }
}
