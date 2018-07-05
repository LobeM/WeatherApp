//
//  Location.swift
//  WeatherApp
//
//  Created by Lobe Musonda on 7/5/18.
//  Copyright © 2018 Lobe Musonda. All rights reserved.
//

import Foundation

class Location: Codable {
    let current: Current
}

struct Current: Codable {
    let temp_c: String
    let condition: Condition
}

struct Condition: Codable {
    let description: String
    let iconUrl: String
}
