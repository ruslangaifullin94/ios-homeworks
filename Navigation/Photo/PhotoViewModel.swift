//
//  PhotoViewModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 30.05.2023.
//

import iOSIntPackage
import UIKit

protocol PhotoViewModelProtocol: AnyObject {
    func setupFiltersInCollection()
    var stateChanger: ((PhotoViewModel.State) -> Void)? { get set}
}

final class PhotoViewModel {
    
    //MARK: - Properties
    
    let imageProcessor = ImageProcessor()
    enum State {
        case filterOff
        case filterON
    }
     var stateChanger: ((State) -> Void)?
    
    private var state: State = .filterOff {
        didSet {
            stateChanger?(state)
        }
    }
}



//MARK: - PhotoViewModelProtocol

extension PhotoViewModel: PhotoViewModelProtocol {
    func setupFiltersInCollection() {
        
        let startTime = NSDate()
        
        imageProcessor.processImagesOnThread(
            sourceImages: newPhotoAlbum,
            filter: .colorInvert,
            qos: .userInitiated) {
                images in
            
            DispatchQueue.main.async {
                newPhotoAlbum = []
                for image in images {
                    guard let image = image else {return}
                    newPhotoAlbum.append(UIImage(cgImage: image))
                }
                
                let finishTime = NSDate()
                
                let timer = finishTime.timeIntervalSince(startTime as Date)
                print("Время выполнения \(timer)")
                self.state = .filterON
            }
        }
    }
    
    
}
