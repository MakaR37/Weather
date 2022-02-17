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
                self.getWeatherNow(latitude: locationLatitude, longitude: locationLongitude)
                self.getWeatherDetailed(latitude: locationLatitude, longitude: locationLongitude)
            case .failure(let error):
                self.view?.showError(text: error.localizedDescription)
            }
        }
    }
    
    private func getWeatherNow(latitude: Double, longitude: Double) {
        WeatherNetworkService.share.getWeatherNow(lat: latitude, lon: longitude, completion: { result in
            switch result {
            case .success(let weatherNow):
                DispatchQueue.main.async {
                    self.view?.configure(with: weatherNow)
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        })
    }
    
    private func getWeatherDetailed(latitude: Double, longitude: Double) {
        WeatherNetworkService.share.getWeatherDetailed(lat: latitude, lon: longitude, completion: { result in
            switch result {
            case .success(let weatherDetail):
                DispatchQueue.main.async {
                    self.view?.configure(with: weatherDetail.hourly)
                    self.view?.configure(with: weatherDetail.daily)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
