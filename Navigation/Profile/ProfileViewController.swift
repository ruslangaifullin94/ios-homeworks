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
    func closePhoto(image: UIImageView, point: CGPoint)
}

class ProfileViewController: UIViewController {
   
    //MARK: - Properties
    
    fileprivate let data = Post.make()
    
    private var pointOnPhoto: CGPoint?
    private var profileAvatar: UIImageView?
  
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var backgroundPhotoView: UIView = {
        let photoView = UIView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.alpha = 0
        photoView.backgroundColor = .black
        photoView.isHidden = false
        return photoView
    }()
    
    private lazy var closePhotoButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(cancelAnimation), for: .touchUpInside)
        return button
    }()
    
   private lazy var profileHeaderView: ProfileHeaderView  = {
        let headerView = ProfileHeaderView()
        headerView.delegate = self
       return headerView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
       
    }
    
    override func viewWillLayoutSubviews() {
        addSubviews()
        setupView()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Metods
    
    private func addSubviews(){
        view.addSubview(tableView)
        view.addSubview(backgroundPhotoView)
        view.addSubview(closePhotoButton)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            backgroundPhotoView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundPhotoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundPhotoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundPhotoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            closePhotoButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 10),
            closePhotoButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -10)

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
    
    
    
    @objc private func cancelAnimation() {
        closePhoto(image: profileAvatar!, point: pointOnPhoto!)
    }
    
    
}

//MARK: Extensions

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            photosViewController.title = "Profile Photo"
            self.navigationController?.pushViewController(photosViewController, animated: true)
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
            cell.update(data[indexPath.row])
            return cell
        }
    }

}
extension ProfileViewController: ProfileViewControllerDelegate {
   
    
    func presentAlert(image: UIImageView) {
        print("i work")
        let optionMenu = UIAlertController(title: nil, message: "Profile photo", preferredStyle: .actionSheet)

        let openAction = UIAlertAction(title: "Открыть фото", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            guard let header = self.tableView.tableHeaderView as? ProfileHeaderView else {return}
            header.animatePhoto(image: image)
//            animatePhoto
//            self.openPhoto(image: image)
                
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
    
    func savePoint(image: UIImageView) -> CGPoint {
        let point = image.center.self
        return point
    }
    
    
    
    func openPhoto(image: UIImageView) {
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
                    
                    self.backgroundPhotoView.alpha = 0.5
                    
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3)
                {
                    self.closePhotoButton.alpha = 1
                    image.layer.cornerRadius = 0.0
                    image.layer.borderWidth = 0
                    self.closePhotoButton.isHidden = false
                }
            
            },
            completion: {_ in
                self.navigationController?.tabBarController?.tabBar.isHidden = true
//                self.profileAvatar!.center = CGPoint(x: self.backgroundPhotoView.bounds.midX, y: self.backgroundPhotoView.bounds.midY)
//
////                self.backgroundPhotoView.addSubview(self.profileAvatar)
            }
        )
    }
    func closePhoto(image: UIImageView, point: CGPoint) {
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.1,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    self.closePhotoButton.alpha = 0
                    image.layer.cornerRadius = 60
                    image.layer.borderWidth = 3
                    self.backgroundPhotoView.alpha = 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                    image.transform = CGAffineTransform(scaleX: 1, y: 1)
                    image.center = point
                    
                    self.closePhotoButton.isHidden = true

                }
            },
            completion: {_ in
                self.navigationController?.tabBarController?.tabBar.isHidden = false
            }
        )
    }
    
    
}
