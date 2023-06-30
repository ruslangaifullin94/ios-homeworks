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
    
    private lazy var audioTracks: [String: AVPlayerItem] = [:]
    
    private lazy var playlist = [AVPlayerItem](audioTracks.values)
    
    weak var delegate: MultimediaServiceDelegate?
    
    private var player: AVPlayer?
    
    init() {
        getAudio()
        setupAudioPlayer()
        
    }
    
    private func getAudio() {
        guard let path = Bundle.main.resourcePath else {
            fatalError()
        }
        let files = try! FileManager.default.contentsOfDirectory(atPath: path)
        let mp3Files = files.filter { $0.hasSuffix(".mp3") }

        for mp3File in mp3Files {
            if let url = Bundle.main.url(forResource: mp3File, withExtension: nil) {
                let track = AVPlayerItem(url: url)
                let trackTitle = url.lastPathComponent
                audioTracks[trackTitle] = track
            }
        }
    }
    
    private func setupAudioPlayer() {
        let player = AVPlayer()
        player.replaceCurrentItem(with: playlist.randomElement())
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [weak self] _ in
            self?.playNextAudio()
        }
        self.player = player
    }
    
    private func getDuration() -> Float {
        let duration = CMTimeGetSeconds(player?.currentItem?.duration ?? .zero)
        let time = Float(duration)
        return time
    }
    
    private func getTitleAudio(){
        if let currentItem = player?.currentItem {
            let title = audioTracks.first { $0.value == currentItem }?.key
                delegate?.updateNameLabel(name: title!)
            }
        }
    
    
    private func progressAudio() {
        player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1000), queue: .main) { [weak self] time in
             let currentTime = CMTimeGetSeconds(time)
             self?.delegate?.updateSlider(newValue: Float(currentTime))
         }
     
     }
}

extension MultimediaService: MultimediaServiceProtocol {
    
    func playPlayer() {
        player?.play()
        getTitleAudio()
        let value = getDuration()
        delegate?.updateMaxValueSlider(value: value)
        progressAudio()
    }
    
    func pausePlayer() {
        player?.pause()
    }
    
    func playNextAudio() {
        guard let currentItem = player?.currentItem else {
            return
        }
        guard let currentIndex = playlist.firstIndex(of: currentItem) else {
            return
        }
        
        let nextIndex = (currentIndex + 1) % playlist.count
        let nextItem = playlist[nextIndex]
        
        player?.seek(to: .zero)
        
        player?.replaceCurrentItem(with: nextItem)
        player?.play()
        getTitleAudio()

//        playPlayer()
    }
    
    func playPreviousAudio() {
        guard let currentItem = player?.currentItem else {
            return
        }
        guard let currentIndex = playlist.firstIndex(of: currentItem) else {
            return
        }
        
        var previousIndex = 0
        
        currentIndex == 0 ? (previousIndex = 0) : (previousIndex = (currentIndex - 1) % playlist.count)
        
        
        let previousItem = playlist[previousIndex]
        player?.seek(to: .zero)
        
        player?.replaceCurrentItem(with: previousItem)
        player?.play()
        getTitleAudio()

//        playPlayer()
    }
    
    func stopPlayer() {
        player?.pause()
        player?.seek(to: .zero)
        delegate?.updateNameLabel(name: "")
    }
    
    func changeValueSlider(value: Float) {
        let seconds = Double(value)
        let time = CMTime(seconds: seconds, preferredTimescale: 1000)
        player?.seek(to: time)
    }
    
}
