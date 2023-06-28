//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit
protocol ProfileViewControllerDelegate: AnyObject {
    func presentAlert(image: UIImageView, background: UIView, close: UIButton)
    func openPhoto(image: UIImageView, background: UIView, close: UIButton)
    func savePoint(image: UIImageView) -> CGPoint
    func closePhoto(image: UIImageView, background: UIView, close: UIButton)
}

final class ProfileViewController: UIViewController {
   
    
    //MARK: - Properties
    
    private let viewModel: ProfileViewModelProtocol
    
    private var pointOnPhoto: CGPoint?
    private var profileAvatar: UIImageView?
  
    
     lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: CellReuseID.header.rawValue)
         tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: CellReuseID.photo.rawValue)
         tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
         tableView.separatorInset = .zero
        return tableView
    }()

//   private lazy var profileHeaderView: ProfileHeaderView  = {
//        let headerView = ProfileHeaderView()
//       headerView.setupUser(self.viewModel.currentUser)
//        headerView.delegate = self
//       return headerView
//    }()
    
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
//        bindViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK: - Private Methods
    
//    private func bindViewModel() {
//        viewModel.stateChanger = { [weak self] state in
//            switch state {
//            case .loading:
//                ()
//            case .loaded:
//                ()
//            }
//        }
//    }
    
    private func addSubviews(){
        view.addSubview(tableView)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        title = viewModel.currentUser.userName

        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
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
        section == 0 ? 1 : viewModel.data.count
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 180 : UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPath.section == 0 ? self.viewModel.didTapPhotoCollection() : tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellReuseID.header.rawValue) as? ProfileHeaderView else { fatalError("error")}
            header.setupUser(self.viewModel.currentUser)
            header.delegate = self
            return header
        } else {
            return nil
        }

    }
    
}


//MARK: - ProfileViewControllerDelegate

extension ProfileViewController: ProfileViewControllerDelegate {
   
    
    func presentAlert(image: UIImageView, background: UIView, close: UIButton) {
        print("i work")
        let optionMenu = UIAlertController(title: nil, message: "Profile photo", preferredStyle: .actionSheet)

        let openAction = UIAlertAction(title: "Открыть фото", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            self.openPhoto(image: image, background: background, close: close)
                
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
    
    
    
    func openPhoto(image: UIImageView, background: UIView, close: UIButton) {
//        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: CellReuseID.header.rawValue) as? ProfileHeaderView else {return}
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
                    background.alpha = 1

                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5)
                {
                    close.alpha = 0.5
                    image.layer.cornerRadius = 0.0
                    image.layer.borderWidth = 0
                }

            },
            completion: {_ in
//                header.backgroundPhoto.alpha = 1
                self.navigationController?.tabBarController?.tabBar.isHidden = true
                self.tableView.isScrollEnabled = false
                self.tableView.allowsSelection = false
     
            }
        )
    }
    func closePhoto(image: UIImageView, background: UIView, close: UIButton) {
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.1,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    close.alpha = 0
                    self.profileAvatar!.layer.cornerRadius = 60
                    self.profileAvatar!.layer.borderWidth = 3
                    background.alpha = 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                    self.profileAvatar!.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.profileAvatar!.center = self.pointOnPhoto!
                    close.isHidden = true

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
