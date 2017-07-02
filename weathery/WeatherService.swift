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
    
    enum Reply {
        case success(WeatherData), failure(Error)
    }
    
    static func requestWeather(response callback: @escaping (Reply) -> Void) {
        if Configuration.isUITesting {
            mockedRequestWeather(response: callback)
            return
        }
        
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
    
    // MARK: Mocking for UITests
    
    private static var mockRequestCounter = 0
    
    enum MockError: Error { case message(String) }
    
    private static func mockedRequestWeather(response callback: @escaping (Reply) -> Void) {
        //hard fail (!) because only used for UITesting
        let variable = Configuration.uiTest(variable: "WeatherRequest\(mockRequestCounter)")!
        mockRequestCounter += 1
        
        if let message = variable.removingPrefix("error: ") {
            callback(.failure(MockError.message(message)))
        } else if let json = variable.removingPrefix("reply: ") {
            do {
                let data = json.data(using: .utf8)!
                callback(.success(try WeatherData(data)))
            } catch {
                callback(.failure(error))
            }
        } else {
            callback(.failure(MockError.message("Invalid mocked string")))
        }
    }
}
