//
//  HourlyTemperatureView.swift
//  Weather
//
//  Created by Артем Мак on 10.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

class HourlyTemperatureView: UIView {
    
    private var hourles: [Hourly] = []
    
    private lazy var watchImageView: UIImageView = {
        let watchImageView = UIImageView()
        watchImageView.image = UIImage(named: "watch")
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        return watchImageView
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let hourlyForecastLabel = UILabel()
        hourlyForecastLabel.text = "ПОЧАСОВОЙ ПРОГНОЗ"
        hourlyForecastLabel.font = .systemFont(ofSize: 12)
        hourlyForecastLabel.textColor = UIColor(
            red: (138/255.0),
            green: (148/255.0),
            blue: (165/255.0),
            alpha: 1
        )
        hourlyForecastLabel.translatesAutoresizingMaskIntoConstraints = false
        return hourlyForecastLabel
    }()
    
    private lazy var colletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let colletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifire)
        colletionView.backgroundColor = UIColor(
            red: (80/255.0),
            green: (91/255.0),
            blue: (107/255.0),
            alpha: 1
        )
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.contentInset = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        return colletionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(hourles: [Hourly]) {
        self.hourles = hourles
        colletionView.reloadData()
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
        addSubview(colletionView)
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
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            colletionView.topAnchor.constraint(equalTo: watchImageView.bottomAnchor),
            colletionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colletionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colletionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colletionView.heightAnchor.constraint(equalToConstant: 110)
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
        return hourles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifire, for: indexPath) as? HourlyForecastCollectionViewCell {
            let hourly = hourles[indexPath.row]
            var date = String()
            date.convertDateSince1970(date: hourly.dt, formatDate: "hh", locale: "ru")
            cell.configurate(date: date, imageLink: hourly.weather.first?.icon ?? "" , temperature: hourly.temp)
            return cell
        }
        return UICollectionViewCell()
    }
}


