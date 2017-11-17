//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by 席银军 on 2017/11/16.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_weatherDataAt_starts_the_session() {
        let session = MockURLSession()
        let dataTask = MockURLSessionDataTask()
        
        session.sessionDataTask = dataTask
        
        let url = URL(string: "https://darksky.net")!
        let manager = WeatherDataManager(baseURL: url, urlSession: session)
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {_, _ in })
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_gets_data() {
        
        let expect = expectation(description: "Loding data from \(API.authenticatedUrl)")
        
        var data: WeatherData? = nil
        WeatherDataManager.shared.weatherDataAt(latitude: 52, longitude: 100, completion: {
            (response, error) in
            data = response
           
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weatherDataAt_handle_invalid_request() {
        let session = MockURLSession()
        session.responseError = NSError(domain: "Invalid Request", code: 100, userInfo: nil)
        
        let manager = WeatherDataManager(baseURL: URL(string: "http://darksky.net")!, urlSession: session)
        var error: DataManagerError? = nil
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {
            (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_invalid_response() {
        let url = URL(string: "https://darksky.net")!
        let session = MockURLSession()
        session.responseHeader = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // Make a invalid JSON response here
        let data = "{".data(using: .utf8)!
        
        session.responseData = data
        
        var error: DataManagerError? = nil
        let manager = WeatherDataManager(baseURL: url, urlSession: session)
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {
            (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func test_weatherDataAt_handle_response_decode() {
        let url = URL(string: "http://darksky.net")!
        let session = MockURLSession()
        session.responseHeader = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = """
        {
            "longitude": 100,
            "latitude": 50,
            "currently": {
                "temperature": 23,
                "humidity": 0.91,
                "time": 1507180335,
                "summary": "Light Snow"
            }
        }
        """.data(using: .utf8)!
        session.responseData = data
        
        var decoded: WeatherData? = nil
        let manager = WeatherDataManager(baseURL: url, urlSession: session)
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {(d, _) in
            decoded = d
        })
        
        let expected = WeatherData(latitude: 52, longitude: 100, currently: WeatherData.CurrentWeather(time: Date(timeIntervalSince1970: 1507180335), summary: "Light Snow", icon: "snow", temperature: 23, humidity: 0.91))
        
        XCTAssertEqual(decoded, expected)
    }
    
}
