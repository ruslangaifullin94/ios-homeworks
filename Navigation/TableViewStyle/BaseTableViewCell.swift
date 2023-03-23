//
//  BaseTableViewCell.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.03.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update (_ model: Post) {
        textLabel?.text = model.author
        imageView?.image = UIImage(named: model.image)
        
    }
}
