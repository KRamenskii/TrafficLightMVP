//
//  Presenter.swift
//  TrafficLightMVP
//
//  Created by Kirill on 01.11.2021.
//

import Foundation

class Presenter {
    
    weak private var viewInputDekegate: ViewInputDelegate?
    var cells = TypeCell.cells
    var titles = TypeButton.buttons
    
    func setViewInputDelegate(viewInputDelegate: ViewInputDelegate?) {
        self.viewInputDekegate = viewInputDelegate
    }
    
    func loadData() {
        self.viewInputDekegate?.setupData(with: self.cells, with: self.titles)
        self.viewInputDekegate?.displayData(index: 0, title: titles.title)
    }
    
    func actionsButton() -> TypeButton {
        return titles
    }
    
    func setActiveParametersForCells() {
        self.viewInputDekegate?.setupParametersForCells(self.cells[1])
    }
    
    func setPassiveParametersForCells() {
        self.viewInputDekegate?.setupParametersForCells(self.cells[0])
    }
}

extension Presenter: ViewOutputDelegate {
    
    // MARK: - Functions for changing the traffic light mode
    
    func setActiveParameters() {
        setActiveParametersForCells()
    }
    
    func setPassiveParameters() {
        setPassiveParametersForCells()
    }
    
    // MARK: - Functions for changing the buttons mode
    
    func startModel() -> TypeButton {
        var button = actionsButton()
        
        button.title = titlesButton[1]
        button.modelIsActive = true
        
        return button
    }
    
    func stopModel() -> TypeButton {
        var button = actionsButton()
        
        button.title = titlesButton[0]
        button.modelIsActive = false
        
        return button
    }
    
    // MARK: - Set initial parameters
    
    func getData() {
        self.loadData()
    }
}
