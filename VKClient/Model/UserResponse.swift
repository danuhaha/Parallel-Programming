//
//  UserResponse.swift
//  VKClient
//
//  Created by danuhaha on 29.11.2021.
//

import Foundation
import UIKit

struct UserInitialResponse: Codable {
    let response: UserResponse
}

struct UserResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthday: String
    let avatar: String
    let status: String
    let universityName: String
    let facultyName: String
    let city: UserCity
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case birthday = "bdate"
        case avatar = "photo_max"
        case status = "status"
        case universityName = "university_name"
        case facultyName = "faculty_name"
        case city = "city"
    }
}

struct UserCity: Codable {
    let title: String
}
