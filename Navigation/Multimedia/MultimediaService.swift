//
//  MultimediaService.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 20.06.2023.
//

import AVFoundation
protocol MultimediaServiceDelegate: AnyObject {
    func updateSlider(newValue: Float)
    func updateMaxValueSlider(value: Float)
    func updateNameLabel(name: String)
   
}

protocol MultimediaServiceProtocol {
    func playPlayer()
    func pausePlayer()
    func playNextAudio()
    func playPreviousAudio()
    func stopPlayer()
    func changeValueSlider(value: Float)
}

final class MultimediaService {
    
    
    private let path1 = Bundle.main.path(forResource: "dali", ofType: "mp3")
    private let path2 = Bundle.main.path(forResource: "strely", ofType: "mp3")
    private let path3 = Bundle.main.path(forResource: "cubaLibre", ofType: "mp3")
    
    private lazy var url1 = URL(fileURLWithPath: path1 ?? "")
    private lazy var url2 = URL(fileURLWithPath: path2 ?? "")
    private lazy var url3 = URL(fileURLWithPath: path3 ?? "")
    
    private lazy var playerItem1 = AVPlayerItem(url: url1)
    private lazy var playerItem2 = AVPlayerItem(url: url2)
    private lazy var playerItem3 = AVPlayerItem(url: url3)

    private lazy var playlist = [playerItem1, playerItem2, playerItem3]
    
    weak var delegate: MultimediaServiceDelegate?
    
    private var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    init() {
      
        setupAudioPlayer()
        
    }
    
    private func setupAudioPlayer() {
        player.replaceCurrentItem(with: playlist[0])
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [weak self] _ in
            self?.playNextAudio()
        }
    }
    
    private func getDuration() -> Float {
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? .zero)
        let time = Float(duration)
        return time
    }
    
    private func getTitleAudio(){
        if let currentItem = player.currentItem {
            if currentItem == playerItem1 {
                delegate?.updateNameLabel(name: "Markul - Dali")
            } else if currentItem == playerItem2 {
                delegate?.updateNameLabel(name: "Markul - Стрелы")
            } else {
                delegate?.updateNameLabel(name: "Markul - Cuba Libre")
            }
        }
    }
    
    private func progressAudio() {
         player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1000), queue: .main) { [weak self] time in
             let currentTime = CMTimeGetSeconds(time)
             self?.delegate?.updateSlider(newValue: Float(currentTime))
         }
     }
   
}

extension MultimediaService: MultimediaServiceProtocol {
    
    func playPlayer() {
        player.play()
        getTitleAudio()
        let value = getDuration()
        delegate?.updateMaxValueSlider(value: value)
        progressAudio()
    }
    
    func pausePlayer() {
        player.pause()
    }
    
    func playNextAudio() {
        guard let currentItem = player.currentItem else {
            return
        }
        guard let currentIndex = playlist.firstIndex(of: currentItem) else {
            return
        }
        
        let nextIndex = (currentIndex + 1) % playlist.count
        let nextItem = playlist[nextIndex]
        
        player.seek(to: .zero)
        
        player.replaceCurrentItem(with: nextItem)
        player.play()
        getTitleAudio()

//        playPlayer()
    }
    
    func playPreviousAudio() {
        guard let currentItem = player.currentItem else {
            return
        }
        guard let currentIndex = playlist.firstIndex(of: currentItem) else {
            return
        }
        
        var previousIndex = 0
        
        currentIndex == 0 ? (previousIndex = 0) : (previousIndex = (currentIndex - 1) % playlist.count)
        
        
        let previousItem = playlist[previousIndex]
        player.seek(to: .zero)
        
        player.replaceCurrentItem(with: previousItem)
        player.play()
        getTitleAudio()

//        playPlayer()
    }
    
    func stopPlayer() {
        player.pause()
        player.seek(to: .zero)
        delegate?.updateNameLabel(name: "")
    }
    
    func changeValueSlider(value: Float) {
        let seconds = Double(value)
        let time = CMTime(seconds: seconds, preferredTimescale: 1000)
        player.seek(to: time)
    }
    
}
