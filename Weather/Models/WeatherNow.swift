//
//  Weather2.swift
//  Weather
//
//  Created by Артем Мак on 15.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

struct WeatherNow: Decodable {
    let weather: [Weather]?
    let main: Main?
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

