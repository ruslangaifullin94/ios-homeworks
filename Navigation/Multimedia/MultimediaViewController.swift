//
//  MultimediaViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 20.06.2023.
//

import UIKit
import WebKit

final class MultimediaViewController: UIViewController {
    
    private var viewModel: MultimediaViewModelProtocol?
    
    private let largeConfigurationSF = UIImage.SymbolConfiguration(scale: .large)
    
    private var videoIDs = ["2VaM8FH7jfs","WmD9xlEOL2A","C-Bm-_TOy0Q"]
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(stackViewMusic)
        stackView.addArrangedSubview(tableView)
        return stackView
    }()
    
    private lazy var stackViewMusic: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(stackViewMusicControl)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(slider)
        return stackView
    }()
    
    private lazy var stackViewMusicControl: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(nextButton)
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    
    private lazy var slider: UISlider = {
       let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "backward.end.circle", withConfiguration: largeConfigurationSF), for: .normal)
        button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "stop.circle", withConfiguration: largeConfigurationSF), for: .normal)
        button.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: largeConfigurationSF), for: .normal)
        button.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "forward.end.circle", withConfiguration: largeConfigurationSF), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        tableView.register(MultimediaViewCell.self, forCellReuseIdentifier: MultimediaViewCell.id)
        return tableView
    }()

    init(viewModel: MultimediaViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupView()
        setupConstraits()
        bindingModel()
    }
    
    private func setupSlider() {
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupView() {
        view.addSubview(stackView)
    }
    
    private func setupConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
        ])
    }
    
    private func bindingModel() {
        viewModel?.stateChanger = { [weak self] state in
            guard let self else {return}
            switch state {
            case .updateStatePlayer(let state):
                switch state {
                case .play:
                    self.playButton.setImage(UIImage(systemName: "pause.circle", withConfiguration: self.largeConfigurationSF), for: .normal)
                case .pause:
                    self.playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: self.largeConfigurationSF), for: .normal)
                case .stop:
                    self.playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: self.largeConfigurationSF), for: .normal)
                }
            case .updateValueSlider(let newValue):
                self.slider.value = newValue
                
            case .updateMaxValueSlider(let value):
                self.slider.minimumValue = 0
                self.slider.maximumValue = value
            case .updateNameLabel(let name):
                self.nameLabel.text = name
            }
        }
    }
    
    @objc private func didTapPreviousButton() {
        viewModel?.didTapPreviousButton()
        
    }
    
    @objc private func didTapStopButton() {
        viewModel?.didTapStopButton()
    }
    
    @objc private func didTapPlayButton() {
        viewModel?.didTapPlayButton()
        
    }
    
    @objc private func didTapNextButton() {
        viewModel?.didTapNextButton()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        viewModel?.changeValueSlider(value: sender.value)
    }
    
//    func setupSlider2() {
//        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? .zero)
//        slider.minimumValue = 0
//        slider.maximumValue = Float(duration)
//
//        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
//
//        player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: .main) { time in
//            let currentTime = CMTimeGetSeconds(time)
//            slider.value = Float(currentTime)
//        }
//
//    }
//
//    @objc func sliderValueChanged(_ sender: UISlider) {
//        let seconds = Double(sender.value)
//        let time = CMTime(seconds: seconds, preferredTimescale: 1)
//        player.seek(to: time)
//    }
}

extension MultimediaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}

extension MultimediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MultimediaViewCell.id) as? MultimediaViewCell else { return UITableViewCell()}
        cell.setupCell(id: videoIDs[indexPath.row])
        return cell
    }
    
    
    
    
}
