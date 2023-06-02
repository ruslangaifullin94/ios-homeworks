//
//  BaseTableViewCell.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.03.2023.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    //MARK: - Private Properties
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let picOfPost: UIImageView = {
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.contentMode = .scaleAspectFit
        pic.backgroundColor = .black
        
        return pic
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let descriptionText: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = .systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    
    //MARK: - Private Methods
    
    private func tuneView() {
        addSubview(authorLabel)
        addSubview(picOfPost)
        addSubview(descriptionText)
        addSubview(likeLabel)
        addSubview(viewsLabel)
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            picOfPost.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            picOfPost.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            picOfPost.heightAnchor.constraint(equalToConstant: frame.size.width),
            picOfPost.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            
            descriptionText.topAnchor.constraint(equalTo: picOfPost.bottomAnchor, constant: 16),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            likeLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            likeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ])
        
    }
    
    //MARK: - Public Methods
    
    func update (_ model: Post) {
        authorLabel.text = model.author
        picOfPost.image = UIImage(named: model.image)
        descriptionText.text = model.description
        likeLabel.text = "Likes: " + String(model.likes)
        viewsLabel.text = "Views: " + String(model.views)
    }
    
}
