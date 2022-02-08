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
        LocationService.shared.getLocation { resuls in
            switch resuls {
            case .success(let location):
                if let locationLatitude = location.first?.coordinate.latitude,
                    let locationLongitude = location.first?.coordinate.longitude {
                    self.view?.showLocation(latitude: String(locationLatitude), longitude: String(locationLongitude))
                }
            case .failure(let error):
               self.view?.showError(text: error.localizedDescription)
            }
        }
    }
}
