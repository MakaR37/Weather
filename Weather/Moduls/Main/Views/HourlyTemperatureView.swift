//
//  HourlyTemperatureView.swift
//  Weather
//
//  Created by Артем Мак on 10.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

class HourlyTemperatureView: UIView {
    
    private lazy var weatherArray: [Weather] = [Weather(date: "Сейчас", image: "rain", temperature: -3), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "rain", temperature: -3), Weather(date: "1", image: "thunderstorm", temperature: 0), Weather(date: "1", image: "rain", temperature: -3)]
    
    private lazy var watchImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.image = UIImage(named: "watch")
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        return watchImageView
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let hourlyForecastLabel = UILabel()
        hourlyForecastLabel.text = "ПОЧАСОВОЙ ПРОГНОЗ"
        hourlyForecastLabel.font = UIFont.systemFont(ofSize: 12)
        hourlyForecastLabel.textColor = UIColor(
            red: (138/255.0),
            green: (148/255.0),
            blue: (165/255.0),
            alpha: 1
        )
        hourlyForecastLabel.translatesAutoresizingMaskIntoConstraints = false
        return hourlyForecastLabel
    }()
    
    private lazy var hourlyForecastColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let hourlyForecastColletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        hourlyForecastColletionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyForecastColletionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifire)
        hourlyForecastColletionView.backgroundColor = UIColor(
            red: (80/255.0),
            green: (91/255.0),
            blue: (107/255.0),
            alpha: 1
        )
        hourlyForecastColletionView.delegate = self
        hourlyForecastColletionView.dataSource = self
        hourlyForecastColletionView.contentInset = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
        return hourlyForecastColletionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = UIColor(
            red: (80/255.0),
            green: (91/255.0),
            blue: (107/255.0),
            alpha: 1
        )
        addSubview(watchImageView)
        addSubview(hourlyForecastLabel)
        addSubview(hourlyForecastColletionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            watchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            watchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            watchImageView.widthAnchor.constraint(equalToConstant: 12),
            watchImageView.heightAnchor.constraint(equalToConstant: 12)
            ])
        
        NSLayoutConstraint.activate([
            hourlyForecastLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: watchImageView.trailingAnchor, constant: 5),
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            hourlyForecastLabel.bottomAnchor.constraint(equalTo: watchImageView.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            hourlyForecastColletionView.topAnchor.constraint(equalTo: watchImageView.bottomAnchor),
            hourlyForecastColletionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourlyForecastColletionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hourlyForecastColletionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            hourlyForecastColletionView.heightAnchor.constraint(equalToConstant: 110)
            ])
    }
}

extension HourlyTemperatureView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthFirstCell: CGFloat = 60
        let width = ((collectionView.bounds.width - widthFirstCell - collectionView.contentInset.left - collectionView.contentInset.right) / 5) - 8
        if indexPath.row == 0 {
            return CGSize(width: widthFirstCell, height: 90)
        } else {
            return CGSize(width: width, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension HourlyTemperatureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifire, for: indexPath) as? HourlyForecastCollectionViewCell {
            let weather = weatherArray[indexPath.row]
            cell.configurate(with: weather.date, image: weather.image, temperature: weather.temperature)
            return cell
        }
        return UICollectionViewCell()
    }
}

