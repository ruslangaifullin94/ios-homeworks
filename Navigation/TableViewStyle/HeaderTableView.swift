//
//  UITableView.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 28.03.2023.
//

import UIKit

extension UITableView {
    
    //MARK: - Public Methods
    
    func setAndLayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([


            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220)

        ])
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
