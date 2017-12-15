//
//  WeatherData.swift
//  weathery
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherData {
    
    enum DataError: Error {
        case invalidJSON(String)
    }

    let city: String
    let temperature: Double
    let cloud: Int
    let windSpeed: Double
    let humidity: Int
    
    init(_ data: Data) throws {
        let json = JSON(data: data)
        guard
            let kelvin = json["main"]["temp"].double,
            let city = json["name"].string,
            let cloud = json["clouds"]["all"].int,
            let windSpeed = json["wind"]["speed"].double,
            let humidity = json["main"]["humidity"].int
            
            else {
            throw DataError.invalidJSON(json.description)
        }
        
        self.city = city
        self.temperature = kelvin - 273.15 //Kelvin to Celcius
        self.cloud = cloud
        self.windSpeed = windSpeed
        self.humidity = humidity
    }
}
