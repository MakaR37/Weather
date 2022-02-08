//
//  ViewController.swift
//  Weather
//
//  Created by Артем Мак on 06.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//
import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationService.shared.getLocation { resuls in
            switch resuls {
            case .success(let location):
                if let locationLatitude = location.first?.coordinate.latitude,
                    let locationLongitude = location.first?.coordinate.longitude {
                    print("latitude: \(locationLatitude)")
                    print("longitude: \(locationLongitude)")
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
