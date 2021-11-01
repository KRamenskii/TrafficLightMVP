//
//  Model.swift
//  TrafficLightMVP
//
//  Created by Kirill on 01.11.2021.
//

import UIKit

struct TypeCell {
    var icon: UIImage?
    var time: Int
    var color: UIColor
}

extension TypeCell {
    static var cells = [
        TypeCell(icon: Icon.passive, time: Time.passive, color: Color.passive),
        TypeCell(icon: Icon.active, time: Time.active, color: Color.active)
    ]
}

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

enum TitleButton {
    static let active = "START"
    static let passive = "STOP"
}
