//
//  TemperatureView.swift
//  Weather
//
//  Created by Артем Мак on 09.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

class TemperatureView: UIView {
    
    private lazy var cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.font = .systemFont(ofSize: 35)
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .white
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityNameLabel
    }()
    
    private lazy var weatherСonditionsLabel: UILabel = {
        let weatherСonditionsLabel = UILabel()
        weatherСonditionsLabel.font = .systemFont(ofSize: 21)
        weatherСonditionsLabel.textAlignment = .center
        weatherСonditionsLabel.textColor = .white
        weatherСonditionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherСonditionsLabel
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.font = .systemFont(ofSize: 120)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    private lazy var temperatureIntervalLabel: UILabel = {
        let temperatureIntervalLabel = UILabel()
        temperatureIntervalLabel.font = .systemFont(ofSize: 19)
        temperatureIntervalLabel.textAlignment = .center
        temperatureIntervalLabel.textColor = .white
        temperatureIntervalLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureIntervalLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstrant()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configurate(weather: WeatherNow) {
        cityNameLabel.text = weather.name
        weatherСonditionsLabel.text = weather.weather.first?.description ?? ""
        temperatureLabel.text = "\(Int(weather.main.temp))°"
        temperatureIntervalLabel.text = String("Макс. \(Int(weather.main.tempMax))°, мин. \(Int(weather.main.tempMin))°")
    }
    
    private func setupView() {
        addSubview(cityNameLabel)
        addSubview(weatherСonditionsLabel)
        addSubview(temperatureLabel)
        addSubview(temperatureIntervalLabel)
    }
    
    private func setupConstrant() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            weatherСonditionsLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            weatherСonditionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherСonditionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherСonditionsLabel.bottomAnchor, constant: -10),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            temperatureIntervalLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: -10),
            temperatureIntervalLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureIntervalLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureIntervalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
    }
}
