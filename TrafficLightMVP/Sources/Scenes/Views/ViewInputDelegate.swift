//
//  ViewInputDelegate.swift
//  TrafficLightMVP
//
//  Created by Kirill on 01.11.2021.
//

import Foundation

protocol ViewInputDelegate: AnyObject {
    func setupData(with cells: [TypeCell], with titleButton: TypeButton)
    func displayData(index: Int, title: String)
    func setupParametersForCells(_ cells: TypeCell)
}
