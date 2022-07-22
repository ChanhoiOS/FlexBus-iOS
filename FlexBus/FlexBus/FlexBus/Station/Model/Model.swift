//
//  Model.swift
//  FlexBus
//
//  Created by 이찬호 on 2022/07/22.
//

import Foundation

// MARK: - StationModel
struct StationModel: Codable {
    let comMsgHeader: StCOMMsgHeader?
    let msgHeader: StMsgHeader?
    let msgBody: StMsgBody?
}

// MARK: - COMMsgHeader
struct StCOMMsgHeader: Codable {
    let responseTime, responseMsgID, requestMsgID, successYN: StJSONNull?
    let returnCode, errMsg: StJSONNull?
}

// MARK: - MsgBody
struct StMsgBody: Codable {
    let itemList: [[String: String?]]?
}

// MARK: - MsgHeader
struct StMsgHeader: Codable {
    let headerMsg, headerCD: String?
    let itemCount: Int?

    enum CodingKeys: String, CodingKey {
        case headerMsg
        case headerCD = "headerCd"
        case itemCount
    }
}

// MARK: - Encode/decode helpers

class StJSONNull: Codable, Hashable {

    public static func == (lhs: StJSONNull, rhs: StJSONNull) -> Bool {
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
