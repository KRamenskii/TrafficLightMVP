//
//  ViewController.swift
//  TrafficLightMVP
//
//  Created by Kirill on 01.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Create timer for App 
    
    private lazy var timer: Timer = {
        let timer = Timer()
        
        return timer
    }()
    
    private lazy var tempTime: Int = {
        let time = Int()
        
        return time
    }()
    
    // MARK: - Delegate
    
    weak private var viewOutputDelegate: ViewOutputDelegate?
    private let presenter = Presenter()
    private var cells: [TypeCell] = []
    private var titles: TypeButton!
    
    // MARK: - Views
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.backgroundColor = .black
        
        return stack
    }()
    
    private let firstCell: UIImageView = {
        let cell = UIImageView()
        
        cell.backgroundColor = .secondaryLabel
        
        return cell
    }()
    
    private let secondCell: UIImageView = {
        let cell = UIImageView()
        
        cell.backgroundColor = .secondaryLabel
        
        return cell
    }()
    
    private let iconCell: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let labelTimer: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 70, weight: .light)
        
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        button.backgroundColor = .systemCyan
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
        
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
        
        presenter.setViewInputDelegate(viewInputDelegate: self)
        self.viewOutputDelegate = presenter
        self.viewOutputDelegate?.getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addSubview(firstCell)
        stackView.addSubview(secondCell)
        view.addSubview(button)
        firstCell.addSubview(iconCell)
        secondCell.addSubview(labelTimer)
    }
    
    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        stackView.layer.cornerRadius = view.frame.size.width * 0.2
        
        firstCell.translatesAutoresizingMaskIntoConstraints = false
        firstCell.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        firstCell.topAnchor.constraint(equalTo: stackView.topAnchor, constant: (0.1 * view.frame.size.width)).isActive = true
        firstCell.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        firstCell.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        firstCell.layer.cornerRadius = (0.7 * stackView.frame.size.width) / 2
        
        secondCell.translatesAutoresizingMaskIntoConstraints = false
        secondCell.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        secondCell.topAnchor.constraint(equalTo: firstCell.bottomAnchor, constant: (0.1 * view.frame.size.width)).isActive = true
        secondCell.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        secondCell.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        secondCell.layer.cornerRadius = (0.7 * stackView.frame.size.width) / 2
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50).isActive = true
        button.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.25).isActive = true
        button.layer.cornerRadius = 25
        
        iconCell.translatesAutoresizingMaskIntoConstraints = false
        iconCell.centerXAnchor.constraint(equalTo: firstCell.centerXAnchor).isActive = true
        iconCell.centerYAnchor.constraint(equalTo: firstCell.centerYAnchor).isActive = true
        iconCell.widthAnchor.constraint(equalTo: firstCell.widthAnchor, multiplier: 0.7).isActive = true
        iconCell.heightAnchor.constraint(equalTo: firstCell.widthAnchor, multiplier: 0.7).isActive = true
        
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        labelTimer.centerXAnchor.constraint(equalTo: secondCell.centerXAnchor).isActive = true
        labelTimer.centerYAnchor.constraint(equalTo: secondCell.centerYAnchor).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    // MARK: - Action
    
    private func setParametersForButton(_ button: TypeButton) {
        titles.modelIsActive = button.modelIsActive
        titles.title = button.title
    }
    
    @objc func actionButton() {
        if titles.modelIsActive == false {
            let tempButton = self.viewOutputDelegate?.startModel()
            button.setTitle(tempButton?.title, for: .normal)
            setParametersForButton(tempButton ?? titles)
            startTimer()
        } else {
            let tempButton = self.viewOutputDelegate?.stopModel()
            button.setTitle(tempButton?.title, for: .normal)
            setParametersForButton(tempButton ?? titles)
            resetTimer()
        }
    }
    
    // MARK: - Timer
    
    private func resetTimer() {
        timer.invalidate()
        self.viewOutputDelegate?.getData()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc private func countDown() -> Int {
        let currentTime = tempTime - 1
        
        labelTimer.text = "\(currentTime)"
        tempTime -= 1
        
        if iconCell.tintColor == Color.passive {
            if tempTime == 0 {
                timer.invalidate()
                self.viewOutputDelegate?.setActiveParameters()
                startTimer()
            }
        } else {
            if tempTime == 0 {
                timer.invalidate()
                self.viewOutputDelegate?.setPassiveParameters()
                startTimer()
            }
        }
        
        return tempTime
    }
}

extension ViewController: ViewInputDelegate {
    
    func setupParametersForCells(_ cells: TypeCell) {
        iconCell.image = cells.icon
        iconCell.tintColor = cells.color
        labelTimer.text = String(cells.time)
        labelTimer.textColor = cells.color
        tempTime = cells.time
    }
    
    func setupData(with cells: [TypeCell], with titleButton: TypeButton) {
        self.cells = cells
        self.titles = titleButton
    }
    
    func displayData(index: Int, title: String) {
        iconCell.image = cells[index].icon
        iconCell.tintColor = cells[index].color
        labelTimer.text = String(cells[index].time)
        labelTimer.textColor = cells[index].color
        tempTime = cells[index].time
        button.setTitle(titles.title, for: .normal)
    }
}
