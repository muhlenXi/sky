//
//  MockURLSessionDataTask.swift
//  SkyTests
//
//  Created by 席银军 on 2017/11/17.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

@testable import Sky

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var isResumeCalled = false
    
    func resume() {
        self.isResumeCalled = true
    }
}
