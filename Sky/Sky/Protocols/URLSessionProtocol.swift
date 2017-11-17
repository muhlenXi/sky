//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by 席银军 on 2017/11/17.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol
}
