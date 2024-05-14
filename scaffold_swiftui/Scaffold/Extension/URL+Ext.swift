//
//  URL+Ext.swift
//  VLCDemo
//
//  Created by ihenryhuang 2023/11/22.
//  Copyright © 2023 Tencent Inc. All rights reserved.
//

import SwiftUI

extension URL {
    func path() -> String {
        self.relativePath.replacingOccurrences(of: "/", with: "")
    }

    func pathWithParams() -> String? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        if let path = components?.path, let query = components?.percentEncodedQuery {
            return "\(path)?\(query)"
        }

        if let path = components?.path, components?.percentEncodedQuery == nil {
            return path
        }
        return nil
    }

    /// 获取URL的参数
    /// - Returns: 参数map
    func params() -> [String: String]? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        guard let queryItems = components?.queryItems else {
            return nil
        }
        var paramMap = [String: String]()
        for item in queryItems {
            if let value = item.value {
                paramMap[item.name] = value
            }
        }
        return paramMap
    }
}
