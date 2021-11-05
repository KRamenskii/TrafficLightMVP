//
//  ViewOutputDelegate.swift
//  TrafficLightMVP
//
//  Created by Kirill on 01.11.2021.
//

import Foundation

protocol ViewOutputDelegate: AnyObject {
    func getData()
    func startModel() -> TypeButton
    func stopModel() -> TypeButton
    func setActiveParameters()
    func setPassiveParameters() 
}
