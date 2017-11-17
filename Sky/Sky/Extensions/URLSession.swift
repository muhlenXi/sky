//
//  URLSession.swift
//  Sky
//
//  Created by 席银军 on 2017/11/17.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}
