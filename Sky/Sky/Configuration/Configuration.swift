//
//  Configuration.swift
//  Sky
//
//  Created by 席银军 on 2017/11/16.
//  Copyright © 2017年 muhlenXi. All rights reserved.
//

import Foundation

struct API {
    private static let key = "939e603ac873c5cb4b7a0ae665a59656"
    private static let baseUrl = URL(string: "https://api.darksky.net/forecast")!
    static let authenticatedUrl = baseUrl.appendingPathComponent(key)
}
