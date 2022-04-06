//
//  GroupResponse.swift
//  VKClient
//
//  Created by danuhaha on 06.04.2022.
//

import Foundation
import UIKit

struct GroupInitialResponse: Codable {
    let response: [GroupResponse]
}

struct GroupResponse: Codable {
    let name: String?
    let photo_200: String?
}
