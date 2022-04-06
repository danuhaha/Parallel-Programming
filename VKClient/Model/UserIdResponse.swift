//
//  UserIdResponse.swift
//  VKClient
//
//  Created by danuhaha on 07.04.2022.
//

import Foundation
import UIKit

struct UserIdInitialResponse: Codable {
    let response: [UserIdResponse]
}

struct UserIdResponse: Codable {
    let firstName: String?
    let lastName: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_max"
    }
}
