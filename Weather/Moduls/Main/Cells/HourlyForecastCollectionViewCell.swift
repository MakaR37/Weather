//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Артем Мак on 10.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "HourlyForecastCollectionViewCell"
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textAlignment = .center
        timeLabel.textColor = .white
        timeLabel.font = .boldSystemFont(ofSize: 15)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        return weatherImageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 20)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configurate(date: String, imageLink: String, temperature: Double) {
        timeLabel.text = date
        temperatureLabel.text = "\(Int(temperature))°"
        getPicture(for: imageLink)
    }
    
    private func getPicture(for link: String) {
        guard let imageUrl = URL(string:"https://openweathermap.org/img/wn/\(link)@2x.png") else {
            DispatchQueue.main.async {
                self.weatherImageView.image = UIImage(named: "placeholder")
            }
            return
        }
        DispatchQueue.global(qos: .utility).async {
            guard let pictureData = NSData(contentsOf: imageUrl as URL),
                let picture = UIImage(data: pictureData as Data) else {
                    DispatchQueue.main.async {
                        self.weatherImageView.image = UIImage(named: "placeholder")
                    }
                    return
            }
            DispatchQueue.main.async {
                self.weatherImageView.image = picture
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        backgroundColor = UIColor(
            red: (80/255.0),
            green: (91/255.0),
            blue: (107/255.0),
            alpha: 1
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
            ])
    }
}
