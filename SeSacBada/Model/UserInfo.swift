//
//  User.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/03.
//

import Foundation

// MARK: - Welcome
struct UserInfo: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - User
struct UserClass: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    //let blocked: JSONNull?
    let role: Role
    let createdAt, updatedAt: String
    //let boards: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}
