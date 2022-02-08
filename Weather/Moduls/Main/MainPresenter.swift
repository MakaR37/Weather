//
//  MainPresenter.swift
//  Weather
//
//  Created by Артем Мак on 08.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import Foundation

class MainPresenter {
    
    var view: MainView?
    
    func viewDidLoad() {
        LocationService.shared.getLocation { result in
            switch result {
            case .success(let location):
                let locationLatitude = location.coordinate.latitude
                let locationLongitude = location.coordinate.longitude
                self.view?.showLocation(latitude: String(locationLatitude), longitude: String(locationLongitude))
            case .failure(let error):
                self.view?.showError(text: error.localizedDescription)
            }
        }
    }
}
