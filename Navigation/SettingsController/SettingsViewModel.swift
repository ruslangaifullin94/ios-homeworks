//
//  SettingsViewModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 29.05.2023.
//

import Foundation

protocol SettingsViewModelProtocol: AnyObject {
    func logoutProfile()
}


final class SettingsViewModel {
    
    //MARK: - Private properties

    private weak var coordinator: ProfileCoordinatorProtocol?
    
    //MARK: - LifeCycles

    init(coordinator: ProfileCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
}



//MARK: - SettingsViewModelProtocol


extension SettingsViewModel: SettingsViewModelProtocol {
    func logoutProfile() {
        coordinator?.logoutProfile()
        
    }
}

