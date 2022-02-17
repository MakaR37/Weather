//
//  Weather2.swift
//  Weather
//
//  Created by Артем Мак on 15.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

struct WeatherNow: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

