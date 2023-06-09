//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 24.05.2023.
//

import Foundation

protocol FeedViewModelProtocol: AnyObject {
    var stateChanger: ((FeedViewModel.State)->Void)? {get set}
    func didTapCheckButton(_ word: String?)
}

final class FeedViewModel {
    
    //MARK: - Properties
    
    var stateChanger: ((State) -> Void)?
    
    private let feedModelService: FeedModelProtocol
    
    enum State {
        case waiting
        case `true`
        case `false`
    }
    
    private var state: State = .waiting {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    //MARK: - Life Cycles
        
    init(feedModelService: FeedModelProtocol) {
        self.feedModelService = feedModelService
    }
    
}



//MARK: - FeedViewModelProtocol

extension FeedViewModel: FeedViewModelProtocol {
    func didTapCheckButton(_ word: String?) {
        feedModelService.check(word) { result in
            switch result {
            case .success(_):
                print("слово ок")
                self.state = .true
            case .failure(let error):
                switch error {
                case .noWord:
                    print("введи слово то")
                    self.state = .false
                case .uncorrectWord:
                    print("Слово не правильное")
                    self.state = .false
                    
                }
            }
        }
    }
}
