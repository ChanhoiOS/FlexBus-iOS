//
//  Apis.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/13.
//

import Foundation

struct Apis {
    static let busRoute = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList"
    static let busStation = "http://ws.bus.go.kr/api/rest/arrive/getArrInfoByRouteAll"
    static let stationInfo = "http://ws.bus.go.kr/api/rest/arrive/getLowArrInfoByStId"
}
