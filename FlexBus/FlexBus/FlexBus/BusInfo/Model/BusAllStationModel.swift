//
//  BusStationModel.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/19.
//

import Foundation

// MARK: - BusAllStationModel
struct BusAllStationModel: Codable {
    let comMsgHeader: AllCOMMsgHeader
    let msgHeader: AllMsgHeader
    let msgBody: AllMsgBody
}

// MARK: - COMMsgHeader
struct AllCOMMsgHeader: Codable {
    let responseTime, responseMsgID, requestMsgID, successYN: AllJSONNull?
    let returnCode, errMsg: AllJSONNull?
}

// MARK: - MsgBody
struct AllMsgBody: Codable {
    let itemList: [[String: String?]]
}

// MARK: - MsgHeader
struct AllMsgHeader: Codable {
    let headerMsg, headerCD: String
    let itemCount: Int

    enum CodingKeys: String, CodingKey {
        case headerMsg
        case headerCD = "headerCd"
        case itemCount
    }
}

// MARK: - Encode/decode helpers

class AllJSONNull: Codable, Hashable {

    public static func == (lhs: AllJSONNull, rhs: AllJSONNull) -> Bool {
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
