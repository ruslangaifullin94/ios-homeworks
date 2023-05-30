//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit
protocol ProfileViewControllerDelegate: AnyObject {
    func presentAlert(image: UIImageView)
    func openPhoto(image: UIImageView)
    func savePoint(image: UIImageView) -> CGPoint
    func closePhoto(image: UIImageView)
}

final class ProfileViewController: UIViewController {
   
    
    //MARK: - Properties
    
    private let viewModel: ProfileViewModelProtocol
    
    private var pointOnPhoto: CGPoint?
    private var profileAvatar: UIImageView?
  
    
     lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

   private lazy var profileHeaderView: ProfileHeaderView  = {
        let headerView = ProfileHeaderView()
       
       headerView.setupUser(self.viewModel.currentUser)
        headerView.delegate = self
       return headerView
    }()
    
    //MARK: - LifeCycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupView()
        tuneTableView()
        bindViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = false
       
    }
    
    
    //MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.stateChanger = { [weak self] state in
            switch state {
            case .loading:
                ()
            case .loaded:
                ()
            }
        }
    }
    
    private func addSubviews(){
        view.addSubview(tableView)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        title = viewModel.currentUser.userName

        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }

        tableView.setAndLayout(headerView: profileHeaderView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: CellReuseID.photo.rawValue)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
    }
    
    
    @objc private func didTapSettingsButton() {
        viewModel.pushSettingsController()
    }
    
}



//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.data.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.photo.rawValue) as? PhotoTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.base.rawValue, for: indexPath) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.update(viewModel.data[indexPath.row])
            return cell
        }
    }
}



//MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            self.viewModel.didTapPhotoCollection()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


//MARK: - ProfileViewControllerDelegate

extension ProfileViewController: ProfileViewControllerDelegate {
   
    
    func presentAlert(image: UIImageView) {
        print("i work")
        let optionMenu = UIAlertController(title: nil, message: "Profile photo", preferredStyle: .actionSheet)

        let openAction = UIAlertAction(title: "Открыть фото", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            self.openPhoto(image: image)
                
                print("Open photo")
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
    
    func savePoint(image: UIImageView) -> CGPoint{
        let point = image.center.self
        return point
    }
    
    
    
    func openPhoto(image: UIImageView) {
        guard let header = self.tableView.tableHeaderView as? ProfileHeaderView else {return}
        pointOnPhoto = savePoint(image: image)
        profileAvatar = image
        let screen = UIScreen.main.bounds.width / image.bounds.width
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.1,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5)
                {

                    image.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                    image.transform = CGAffineTransform(scaleX: screen, y: screen)
                    header.backgroundPhoto.alpha = 0.5

                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3)
                {
                    header.closePhotoButton.alpha = 1
                    image.layer.cornerRadius = 0.0
                    image.layer.borderWidth = 0
                    header.closePhotoButton.isHidden = false
                }

            },
            completion: {_ in
                self.navigationController?.tabBarController?.tabBar.isHidden = true
                self.tableView.isScrollEnabled = false
                self.tableView.allowsSelection = false
     
            }
        )
    }
    func closePhoto(image: UIImageView) {
        
        guard let header = self.tableView.tableHeaderView as? ProfileHeaderView else {return}
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.1,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    header.closePhotoButton.alpha = 0
                    self.profileAvatar!.layer.cornerRadius = 60
                    self.profileAvatar!.layer.borderWidth = 3
                    header.backgroundPhoto.alpha = 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                    self.profileAvatar!.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.profileAvatar!.center = self.pointOnPhoto!
                    header.closePhotoButton.isHidden = true

                }
            },
            completion: {_ in
                self.navigationController?.tabBarController?.tabBar.isHidden = false
                self.tableView.isScrollEnabled = true
                self.tableView.allowsSelection = true
            }
        )
    }
    
    
}
