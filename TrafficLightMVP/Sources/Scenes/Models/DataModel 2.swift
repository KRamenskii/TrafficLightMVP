//
//  DataModel.swift
//  TrafficLightMVP
//
//  Created by Kirill on 04.11.2021.
//

import UIKit

enum Icon {
    static let active = UIImage(systemName: "figure.walk")
    static let passive = UIImage(systemName: "figure.wave")
}

enum Time {
    static let active = 3
    static let passive = 5
}

enum Color {
    static let active = UIColor.systemGreen
    static let passive = UIColor.systemRed
}

let titlesButton = ["START", "STOP"]
