//
//  WeekTemperatureTableViewCell.swift
//  Weather
//
//  Created by Артем Мак on 12.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

class WeekTemperatureTableViewCell: UITableViewCell {
    
    static let identifire = "WeekTemperatureTableViewCell"
    
    private lazy var weekDayLabel: UILabel = {
        let weekDayLabel = UILabel()
        weekDayLabel.textColor = .white
        weekDayLabel.font = .boldSystemFont(ofSize: 20)
        weekDayLabel.translatesAutoresizingMaskIntoConstraints = false
        return weekDayLabel
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        return weatherImageView
    }()
    
    private lazy var temperatureFirstLabel: UILabel = {
        let temperatureFirstLabel = UILabel()
        temperatureFirstLabel.textColor = UIColor(
            red: (138/255.0),
            green: (148/255.0),
            blue: (165/255.0),
            alpha: 1
        )
        temperatureFirstLabel.font = .boldSystemFont(ofSize: 20)
        temperatureFirstLabel.textAlignment = .center
        temperatureFirstLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureFirstLabel
    }()
    
    private lazy var temperatureSecondLabel: UILabel = {
        let temperatureSecondLabel = UILabel()
        temperatureSecondLabel.textColor = .white
        temperatureSecondLabel.font = .boldSystemFont(ofSize: 20)
        temperatureSecondLabel.textAlignment = .center
        temperatureSecondLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureSecondLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = UIEdgeInsets(top: .zero, left: 15, bottom: .zero, right: 15)
        backgroundColor = UIColor(
            red: (80/255.0),
            green: (91/255.0),
            blue: (107/255.0),
            alpha: 1
        )
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(weekDay: String, image: String, tempFirts: Double, tempSec: Double) {
        weekDayLabel.text = weekDay
        temperatureFirstLabel.text = "\(Int(tempFirts))°"
        temperatureSecondLabel.text = "\(Int(tempSec))°"
        getPicture(for: image)
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
        selectionStyle = .none
        contentView.addSubview(weekDayLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureFirstLabel)
        contentView.addSubview(temperatureSecondLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weekDayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weekDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            weekDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            weekDayLabel.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherImageView.leadingAnchor.constraint(equalTo: weekDayLabel.trailingAnchor, constant: 16),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            weatherImageView.widthAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            temperatureFirstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            temperatureFirstLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            temperatureFirstLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            temperatureFirstLabel.widthAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            temperatureSecondLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            temperatureSecondLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            temperatureSecondLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            temperatureSecondLabel.widthAnchor.constraint(equalToConstant: 50)
            ])
    }
}
