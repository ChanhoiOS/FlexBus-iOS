//
//  String+Extension.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/14.
//

import Foundation

extension String {
    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
}
