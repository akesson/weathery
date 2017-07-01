//
//  ViewController.swift
//  weathery
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noData()
        WeatherService.requestWeather(response: onWeatherDataReply(_:))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func onWeatherDataReply(_ reply: WeatherService.Reply) {
        switch reply {
        case .success(let data):
            updateWith(data: data)
        case .failure(let error):
            break
        }
    }
    
    private func updateWith(data: WeatherData) {
        placeLabel.text = data.city
        tempLabel.text = "\(data.temperature)º"
        cloudLabel.text = "\(data.cloud)%"
        windLabel.text = "\(data.windSpeed)m/s"
        humidityLabel.text = "\(data.humidity)%"
    }
    
    private func noData() {
        placeLabel.text = "---"
        tempLabel.text = "-"
        cloudLabel.text = "-"
        windLabel.text = "-"
        humidityLabel.text = "-"
    }
}

