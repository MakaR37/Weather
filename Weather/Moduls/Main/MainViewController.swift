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
    
    private lazy var imageBackground: UIImageView = {
        let imageBackground = UIImageView()
        imageBackground.image = UIImage(named: "skyBackground")
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.contentMode = UIView.ContentMode.scaleAspectFill
        return imageBackground
    }()
    
    private lazy var presenter = MainPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    private func setupViews() {
        view.addSubview(imageBackground)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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
