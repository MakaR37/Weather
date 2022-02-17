//
//  HourlyWeather.swift
//  Weather
//
//  Created by Артем Мак on 15.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

struct WeatherDetailed: Decodable {
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [WeatherHourly]
}

struct WeatherHourly: Decodable {
    let icon: String
}

struct Daily: Decodable {
    let temp: DailyTemperature
    let weather: [DailyWeather]
}

struct DailyTemperature: Decodable {
    let min: Double
    let max: Double
}

struct DailyWeather: Decodable {
    let icon: String
}
