//
//  WeatherDataManager.swift
//  Sky
//
//  Created by 席银军 on 2017/11/16.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknow
}

final class WeatherDataManager {
    private let baseURL: URL
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticatedUrl)
    
    func weatherDataAt(latitude: Double,
                       longitude: Double,
                       completion: @escaping CompletionHandler) {
        // 1. Concatenate the URL
        let url = baseURL.appendingPathComponent("\(latitude), \(longitude)")
        var request = URLRequest(url: url)

        // 2. Set HTTP header
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpMethod = "GET"
        
        // 3. Launch the request
        URLSession.shared.dataTask(with: request,
                                   completionHandler: {
                                    (data, response, error) -> Void in
            self.didFinishGettingWeatherData(data: data,
                                             response: response,
                                             error: error,
                                             completion: completion)
        }).resume()
        
    }
    
    func didFinishGettingWeatherData(data: Data?,
                                     response: URLResponse?,
                                     error: Error?,
                                     completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            }
        } else {
            completion(nil, .unknow)
        }
    }
}
