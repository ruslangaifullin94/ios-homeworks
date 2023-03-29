//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit
protocol ProfileViewControllerDelegate: AnyObject {
    func presentAlert()
}

class ProfileViewController: UIViewController {
   
    //MARK: - Properties
    
    fileprivate let data = Post.make()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 220
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
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.backgroundColor = .systemGray3
        return headerView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupView()
        tuneTableView()
    }
    
    //MARK: - Metods
    
    private func addSubviews(){
        view.addSubview(tableView)
    }
    private func setupView() {
        view.backgroundColor = .systemBackground
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 0),
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
//        tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterReuseID.base.rawValue)
//        tableView.setAndLayout(headerView: profileHeaderView)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: Extensions

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterReuseID.base.rawValue) as? ProfileHeaderView else {
            fatalError("could not dequeueReusableCell")
        }
        headerView.delegate = self
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.base.rawValue, for: indexPath) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.update(data[indexPath.row])
        return cell
    }

}
extension ProfileViewController: ProfileViewControllerDelegate {
    func presentAlert() {
        let optionMenu = UIAlertController(title: nil, message: "Profile photo", preferredStyle: .actionSheet)

            let openAction = UIAlertAction(title: "Открыть фото", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Saved")
            })

            let closeAction = UIAlertAction(title: "Загрузить новое фото", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Deleted")
            })

            let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            optionMenu.addAction(openAction)
            optionMenu.addAction(closeAction)
            optionMenu.addAction(cancelAction)
        self.navigationController?.present(optionMenu, animated: true)
    }
    
    
}
