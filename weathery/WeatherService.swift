//
//  WeatherService.swift
//  weathery
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class WeatherService {
    private static let urlString = "http://api.openweathermap.org/data/2.5/weather?q=Helsinki,uk&appid=cdc601bce6828db93b68b2cb1f8a6414"
    private static let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Helsinki,uk&appid=cdc601bce6828db93b68b2cb1f8a6414")!
    
    private static let disposeBag = DisposeBag()
    
    enum Reply {
        case success(WeatherData), failure(Error)
    }
    
    static func requestWeather(response callback: @escaping (Reply) -> Void) {
        if Configuration.isUITesting {
            mockedRequestWeather(response: callback)
            return
        }

        RxAlamofire.requestData(.get, urlString).debug()
            .subscribe(onNext: { (response, data) in
            do {
                callback(.success(try WeatherData(data)))
            } catch {
                callback(.failure(error))
            }
            
        }, onError: { error in
            callback(.failure(error))
            
        }).addDisposableTo(disposeBag)
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
