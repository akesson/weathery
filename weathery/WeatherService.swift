//
//  WeatherService.swift
//  weathery
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService {
    private static var url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Helsinki,uk&appid=cdc601bce6828db93b68b2cb1f8a6414")!
    
    enum ServiceError: Error {
        case notJSONInReply
    }
    enum Reply {
        case success(WeatherData), failure(Error)
    }
    
    static func requestWeather(response callback: @escaping (Reply) -> Void) {
        Alamofire.request(url).validate().responseData { response in

            switch response.result {
            case .success(let data):
                
                do {
                    callback(.success(try WeatherData(data)))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
