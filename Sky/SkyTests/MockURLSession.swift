//
//  MockURLSession.swift
//  SkyTests
//
//  Created by 席银军 on 2017/11/17.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

@testable import Sky

class MockURLSession: URLSessionProtocol {
    
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    
    var sessionDataTask = MockURLSessionDataTask()

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        completionHandler(responseData, responseHeader, responseError)
        return sessionDataTask
    }
    
}
