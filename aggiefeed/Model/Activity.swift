//
//  ActivitiesJSON.swift
//  aggiefeed
//
//  Created by Long H. Nguyen on 7/15/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

struct Object : Decodable {
    let objectType: String
}

struct Actor : Decodable {
    let displayName: String?
}

struct Activity : Decodable {
    let title: String
    let actor: Actor
    let object: Object
    let published: String
}
