//
//  ViewController.swift
//  Weather
//
//  Created by Артем Мак on 06.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

protocol MainView {
    func showLocation(latitude: String, longitude: String)
    func showError(text: String)
}

class MainViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageBackground = UIImageView()
        imageBackground.image = UIImage(named: "skyBackground")
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.contentMode = UIView.ContentMode.scaleAspectFill
        return imageBackground
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var temperatureView: TemperatureView = {
        let temperatureView = TemperatureView()
        temperatureView.translatesAutoresizingMaskIntoConstraints = false
        return temperatureView
    }()
    
    private lazy var presenter = MainPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.view = self
        presenter.viewDidLoad()
        temperatureView.configurate(with: "Иваново", state: "Временами снег", temperature: -2, temperatureMax: -2, temperatureMin: -6)
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(temperatureView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension MainViewController: MainView {
    func showLocation(latitude: String, longitude: String) {
        print("latitude: \(latitude), longitude: \(longitude)")
    }
    
    func showError(text: String) {
        print("error: \(text)")
    }
}
