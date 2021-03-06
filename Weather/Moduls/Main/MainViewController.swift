//
//  ViewController.swift
//  Weather
//
//  Created by Артем Мак on 06.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

protocol MainView {
    func configure(with hourles: [Hourly])
    func configure(with weather: WeatherNow)
    func configure(with dailys: [Daily])
    func showError(text: String)
}

class MainViewController: UIViewController {
    
    private lazy var presenter = MainPresenter()
    
    private lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "skyBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var temperatureView: TemperatureView = {
        let temperatureView = TemperatureView()
        return temperatureView
    }()
    
    private lazy var hourlyTemperatureView: HourlyTemperatureView = {
        let hourlyTemperatureView = HourlyTemperatureView()
        return hourlyTemperatureView
    }()
    
    private lazy var weekTemperatureView: WeekTemperatureView = {
        let weekTemperatureView = WeekTemperatureView()
        return weekTemperatureView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(temperatureView)
        stackView.addArrangedSubview(hourlyTemperatureView)
        stackView.addArrangedSubview(weekTemperatureView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            ])
    }
}

extension MainViewController: MainView {
    
    func configure(with weather: WeatherNow) {
        temperatureView.configurate(weather: weather)
    }
    
    func configure(with hourles: [Hourly]) {
        hourlyTemperatureView.configure(hourles: hourles)
    }
    
    func configure(with dailys: [Daily]) {
        weekTemperatureView.configure(week: dailys)
    }
    
    func showError(text: String) {
        let showActionAlertController = UIAlertController(title: text, message: text, preferredStyle: .alert)
        let actionRepeatButton = UIAlertAction(title: "Повторить", style: .cancel) {_ in
            self.presenter.viewDidLoad()
        }
        showActionAlertController.addAction(actionRepeatButton)
        present(showActionAlertController, animated: true, completion: nil)
    }
}

