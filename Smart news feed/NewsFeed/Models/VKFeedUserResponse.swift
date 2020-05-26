//
//  VKFeedUserResponse.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 26.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}


struct UserResponse: Decodable {
    let photo100: String?
}

