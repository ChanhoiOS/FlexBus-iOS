//
//  busRouteModel.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/13.
//

import Foundation

// MARK: - BusRouteModel
struct BusRouteModel: Codable {
    let comMsgHeader: COMMsgHeader
    let msgHeader: MsgHeader
    let msgBody: MsgBody
}

// MARK: - COMMsgHeader
struct COMMsgHeader: Codable {
    let responseMsgID, responseTime, requestMsgID, successYN: JSONNull?
    let returnCode, errMsg: JSONNull?
}

// MARK: - MsgBody
struct MsgBody: Codable {
    let itemList: [ItemList]
}

// MARK: - ItemList
struct ItemList: Codable {
    let busRouteID, busRouteNm, busRouteAbrv, length: String
    let routeType, stStationNm, edStationNm, term: String
    let lastBusYn, lastBusTm, firstBusTm, lastLowTm: String
    let firstLowTm, corpNm: String

    enum CodingKeys: String, CodingKey {
        case busRouteID = "busRouteId"
        case busRouteNm, busRouteAbrv, length, routeType, stStationNm, edStationNm, term, lastBusYn, lastBusTm, firstBusTm, lastLowTm, firstLowTm, corpNm
    }
}

// MARK: - MsgHeader
struct MsgHeader: Codable {
    let headerMsg, headerCD: String
    let itemCount: Int

    enum CodingKeys: String, CodingKey {
        case headerMsg
        case headerCD = "headerCd"
        case itemCount
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
