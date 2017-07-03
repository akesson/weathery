//
//  ViewController.swift
//  weathery
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, WeatherVMDelegate {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    let vm = WeatherVM()
    
    var dateFormat = DateFormatter(dateStyle: .none, timeStyle: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        vm.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    func willEnterForeground() {
        vm.willEnterForeground()
    }
    
    func weatherUpdated() {
        statusLabel.text = vm.status
        placeLabel.text = vm.place
        tempLabel.text = vm.temp
        cloudLabel.text = vm.cloud
        windLabel.text = vm.wind
        humidityLabel.text = vm.humidity
    }
}

