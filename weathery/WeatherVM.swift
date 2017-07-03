//
//  WeatherVM.swift
//  weathery
//
//  Created by Henrik Akesson on 3/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import Foundation

protocol WeatherVMInputs {
    func viewDidLoad()
    func willEnterForeground()
}

protocol WeatherVMOutputs {
    var place: String { get }
    var temp: String { get }
    var cloud: String { get }
    var wind: String { get }
    var humidity: String { get }
    var status: String { get }
}

protocol WeatherVMDelegate {
    func weatherUpdated()
}

class WeatherVM: WeatherVMInputs, WeatherVMOutputs {
   
    private var dateFormat = DateFormatter(dateStyle: .none, timeStyle: .medium)
    
    var delegate: WeatherVMDelegate?

    private(set) var place = ""
    private(set) var temp = ""
    private(set) var cloud = ""
    private(set) var wind = ""
    private(set) var humidity = ""
    private(set) var status = ""
    
    func viewDidLoad() {
        updateData()
    }
    
    func willEnterForeground() {
        updateData()
    }
    
    private func updateData() {
        updateLabelsWith(nil, status: "Loading...")
        WeatherService.requestWeather(response: onWeatherDataReply(_:))
    }

    private func onWeatherDataReply(_ reply: WeatherService.Reply) {
        switch reply {
        case .success(let data):
            updateLabelsWith(data, status: "Updated \(dateFormat.string(from: Date()))")
        case .failure(let error):
            updateLabelsWith(nil, status: "Error: \(error.localizedDescription)")
        }
    }

    private func updateLabelsWith(_ data: WeatherData?, status: String) {
        self.status = status
        if let data = data {
            place = data.city
            temp = String(format: "%.0f°", data.temperature)
            cloud = "\(data.cloud)%"
            wind = "\(data.windSpeed)m/s"
            humidity = "\(data.humidity)%"
        } else {
            place = "---"
            temp = "-"
            cloud = "-"
            wind = "-"
            humidity = "-"
        }
        delegate?.weatherUpdated()
    }
}
