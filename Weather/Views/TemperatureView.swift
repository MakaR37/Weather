//
//  TemperatureView.swift
//  Weather
//
//  Created by Артем Мак on 09.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import Foundation
import UIKit

class TemperatureView: UIView {
    
    private lazy var cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.text = "Иваново"
        cityNameLabel.font = UIFont.systemFont(ofSize: 35)
        cityNameLabel.textAlignment = .center
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityNameLabel
    }()
    
    private lazy var weatherСonditionsLabel: UILabel = {
        let weatherСonditionsLabel = UILabel()
        weatherСonditionsLabel.text = "Временами снег"
        weatherСonditionsLabel.font = UIFont.systemFont(ofSize: 21)
        weatherСonditionsLabel.textAlignment = .center
        weatherСonditionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherСonditionsLabel
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "-2°"
        temperatureLabel.font = temperatureLabel.font.withSize(150)
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    private lazy var temperatureIntervalLabel: UILabel = {
        let temperatureIntervalLabel = UILabel()
        temperatureIntervalLabel.text = "Макс. -2°, мин. -6°"
        temperatureIntervalLabel.font = UIFont.systemFont(ofSize: 19)
        temperatureIntervalLabel.textAlignment = .center
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
    
    private func setupView() {
        addSubview(cityNameLabel)
        addSubview(weatherСonditionsLabel)
        addSubview(temperatureLabel)
        addSubview(temperatureIntervalLabel)
    }
    
    private func setupConstrant() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            ])
        
        NSLayoutConstraint.activate([
            weatherСonditionsLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: -1),
            weatherСonditionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            weatherСonditionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherСonditionsLabel.bottomAnchor, constant: -10),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            ])
        
        NSLayoutConstraint.activate([
            temperatureIntervalLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: -10),
            temperatureIntervalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            temperatureIntervalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70)
            ])
    }
    
    public func configurate(with cityName: String, state: String, temperature: Int, temperatureMax: Int, temperatureMin: Int) {
        cityNameLabel.text = cityName
        weatherСonditionsLabel.text = state
        temperatureLabel.text = String(temperature)
        temperatureIntervalLabel.text = String("Макс. \(temperatureMax)°, мин. \(temperatureMin)°")
    }
}
