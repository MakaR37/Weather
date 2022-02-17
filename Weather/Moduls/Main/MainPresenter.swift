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
                WeatherNetworkService.share.getWeatherDetailed(lat: locationLatitude, lon: locationLongitude, completion: { result in
                    switch result {
                    case .success(let weatherDetail):
                        DispatchQueue.main.async {
                            self.view?.configure(with: weatherDetail.hourly)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            case .failure(let error):
                self.view?.showError(text: error.localizedDescription)
            }
        }
    }
}
