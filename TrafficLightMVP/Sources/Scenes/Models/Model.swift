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

struct TypeButton {
    var title: String
    var modelIsActive: Bool
}

extension TypeButton {
    static var buttons = TypeButton(title: titlesButton[0], modelIsActive: false)
}
