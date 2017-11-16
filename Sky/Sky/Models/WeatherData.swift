//
//  WeatherData.swift
//  Sky
//
//  Created by 席银军 on 2017/11/16.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}
