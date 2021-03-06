//
//  WeekTemperatureView.swift
//  Weather
//
//  Created by Артем Мак on 12.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import UIKit

class WeekTemperatureView: UIView {
    
    private var days: [Daily] = []
    
    private let calendarImageView: UIImageView = {
        let calendarImageView = UIImageView()
        calendarImageView.image = UIImage(named: "calendar")
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        return calendarImageView
    }()
    
    private let daysForecastLabel: UILabel = {
        let daysForecastLabel = UILabel()
        daysForecastLabel.text = "ПРОГНОЗ НА 10 ДН"
        daysForecastLabel.font = .systemFont(ofSize: 12)
        daysForecastLabel.textColor = UIColor(
            red: (138/255.0),
            green: (148/255.0),
            blue: (165/255.0),
            alpha: 1
        )
        daysForecastLabel.translatesAutoresizingMaskIntoConstraints = false
        return daysForecastLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(WeekTemperatureTableViewCell.self, forCellReuseIdentifier: WeekTemperatureTableViewCell.identifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(week: [Daily]) {
        self.days = week
        tableView.reloadData()
    }
    
    private func setupView() {
        backgroundColor = UIColor(
            red: (80/255.0),
            green: (91/255.0),
            blue: (107/255.0),
            alpha: 1
        )
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(calendarImageView)
        addSubview(daysForecastLabel)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            calendarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            calendarImageView.widthAnchor.constraint(equalToConstant: 12),
            calendarImageView.heightAnchor.constraint(equalToConstant: 12)
            ])
        
        NSLayoutConstraint.activate([
            daysForecastLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            daysForecastLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 5),
            daysForecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendarImageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension WeekTemperatureView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension WeekTemperatureView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeekTemperatureTableViewCell.identifire, for: indexPath) as? WeekTemperatureTableViewCell {
            let day = days[indexPath.row]
            
            var weekDay = String()
            weekDay.convertDateSince1970(date: day.dt, formatDate: "E", locale: "ru")
            
            cell.configure(weekDay: weekDay, image: day.weather.first?.icon ?? "", tempFirts: day.temp.min, tempSec: day.temp.max)
            return cell
        }
        return UITableViewCell()
    }
}
