//
//  MultimediaViewModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 20.06.2023.
//

import Foundation

protocol MultimediaViewModelProtocol {
    func didTapStopButton()
    func didTapPreviousButton()
    func didTapNextButton()
    func didTapPlayButton()
    func changeValueSlider(value: Float)
    var stateChanger: ((MultimediaViewModel.State) -> Void)? {get set}
}

final class MultimediaViewModel {
    
    private var multimediaService: MultimediaServiceProtocol?
    
    enum State {
        case updateStatePlayer(state: StatePlayer)
        case updateValueSlider(newValue: Float)
        case updateMaxValueSlider(value: Float)
        case updateNameLabel(name: String)
    }
    
    enum StatePlayer {
        case play
        case pause
        case stop
    }
        
    var stateChanger: ((State) -> Void)?
    
    private var state: State = .updateStatePlayer(state: .stop) {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    private var statePlayer: StatePlayer = .stop
    
    init(multimediaService: MultimediaServiceProtocol?) {
        self.multimediaService = multimediaService
    }
}

extension MultimediaViewModel: MultimediaViewModelProtocol {
    func didTapPlayButton() {
        
        if statePlayer == .play {
            multimediaService?.pausePlayer()
            state = .updateStatePlayer(state: .pause)
            statePlayer = .pause
        } else {
            multimediaService?.playPlayer()
            state = .updateStatePlayer(state: .play)
            statePlayer = .play
        }
    }
    
    func didTapNextButton() {
        multimediaService?.playNextAudio()
        state = .updateStatePlayer(state: .play)
    }
    
    func didTapPreviousButton() {
        multimediaService?.playPreviousAudio()
        state = .updateStatePlayer(state: .play)
    }
    
    func didTapStopButton() {
        multimediaService?.stopPlayer()
        state = .updateStatePlayer(state: .stop)
        statePlayer = .stop
    }
    
    func changeValueSlider(value: Float) {
        multimediaService?.changeValueSlider(value: value)
    }
    
}

extension MultimediaViewModel: MultimediaServiceDelegate {
    func updateMaxValueSlider(value: Float) {
        state = .updateMaxValueSlider(value: value)
    }
    
    func updateSlider(newValue: Float) {
        state = .updateValueSlider(newValue: newValue)
    }
    
    func updateNameLabel(name: String) {
        state = .updateNameLabel(name: name)
    }
    
    
}
