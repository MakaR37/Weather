//
//  WeatherSearchNetworkService.swift
//  Weather
//
//  Created by Артем Мак on 15.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import Foundation

struct  WeatherNetworkService {
    static var share = WeatherNetworkService()
    
    func getWeatherNow(lat: Double, lon: Double, completion: @escaping (Result<WeatherNow, Error>)-> Void) {
        let apiLink = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=57d5f10b9093291c4629c30ca9b6da8a&lang=ru&units=metric"
        guard let url = URL(string: apiLink) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let weatherNow = try JSONDecoder().decode(WeatherNow.self, from: data)
                completion(.success(weatherNow))
            } catch {
                completion(.failure(error))
            }
            }.resume()
    }
    
    func getWeatherDetailed(lat: Double, lon: Double, completion: @escaping (Result<WeatherDetailed, Error>)-> Void) {
        let apiLink = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts,current&appid=57d5f10b9093291c4629c30ca9b6da8a&units=metric"
        guard let url = URL(string: apiLink) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let weatherDetailed = try JSONDecoder().decode(WeatherDetailed.self, from: data)
                completion(.success(weatherDetailed))
            } catch {
                completion(.failure(error))
            }
            }.resume()
    }
}

