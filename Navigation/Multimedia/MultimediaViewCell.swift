//
//  MultimediaViewCell.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 21.06.2023.
//

import UIKit
import WebKit

class MultimediaViewCell: UITableViewCell {
    
    static let id = "LinkCell"
    
    private let view: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 10, y: 10, width: Int(UIScreen.main.bounds.width) - 20, height: Int(UIScreen.main.bounds.width) * 9/16 ))
        webView.navigationDelegate = self
        webView.isUserInteractionEnabled = true
        return webView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(view)
        setupConstraits()
        view.addSubview(webView)
        

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setupCell(id: String) {
        if let videoURL = URL(string: "https://www.youtube.com/embed/\(id)") {
            let request = URLRequest(url: videoURL)
            webView.load(request)
        }
    }

}

extension MultimediaViewCell: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
       }
}
