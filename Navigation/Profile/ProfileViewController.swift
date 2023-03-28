//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
   
    fileprivate let data = Post.make()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
        case custom = "CustomTableViewCell_ReuseID"
    }
    
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
    }
    
    
    
    var profileHeaderView: ProfileHeaderView  = {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemGray3
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        title = "Profile"
        addSubviews()
        setupView()
        tuneTableView()
    }
    private func addSubviews(){
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)
    }
    private func setupView() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            tableView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        tableView.backgroundColor = .systemRed
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.base.rawValue, for: indexPath) as? BaseTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(data[indexPath.row])
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
}
