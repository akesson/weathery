//
//  ViewController.swift
//  weathery
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    enum UpdateType {
        case newData(WeatherData), error(Error), noData
    }
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var dateFormat = DateFormatter(dateStyle: .none, timeStyle: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    func updateData() {
        updateLabelsWith(nil, status: "Loading...")
        WeatherService.requestWeather(response: onWeatherDataReply(_:))
    }

    func onWeatherDataReply(_ reply: WeatherService.Reply) {
        switch reply {
        case .success(let data):
            updateLabelsWith(data, status: "Updated \(dateFormat.string(from: Date()))")
        case .failure(let error):
            updateLabelsWith(nil, status: "Error: \(error.localizedDescription)")
        }
    }
    
    private func updateLabelsWith(_ data: WeatherData?, status: String) {
        statusLabel.text = status
        if let data = data {
            placeLabel.text = data.city
            tempLabel.text = String(format: "%.0f°", data.temperature)
            cloudLabel.text = "\(data.cloud)%"
            windLabel.text = "\(data.windSpeed)m/s"
            humidityLabel.text = "\(data.humidity)%"
        } else {
            placeLabel.text = "---"
            tempLabel.text = "-"
            cloudLabel.text = "-"
            windLabel.text = "-"
            humidityLabel.text = "-"
        }
    }
}

