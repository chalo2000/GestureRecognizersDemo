//
//  ViewController.swift
//  GestureRecognizersDemo
//
//  Created by Gonzalo Gonzalez on 11/27/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: UI Elements
    let ornamentImageView: UIImageView = UIImageView()
    let presentImageView: UIImageView = UIImageView()
    let treeImageView: UIImageView = UIImageView()
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        ornamentImageView.translatesAutoresizingMaskIntoConstraints = false
        ornamentImageView.image = UIImage(named: "ornament3")
        view.addSubview(ornamentImageView)
        
        presentImageView.translatesAutoresizingMaskIntoConstraints = false
        presentImageView.image = UIImage(named: "present3")
        view.addSubview(presentImageView)
        
        treeImageView.translatesAutoresizingMaskIntoConstraints = false
        treeImageView.image = UIImage(named: "tree")
        view.addSubview(treeImageView)
    }
    
    private func setupConstraints() {
        let ornamentImageViewSize: CGSize = getDimensions(for: ornamentImageView)
        let presentImageViewSize: CGSize = getDimensions(for: presentImageView)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let treeImageViewSize: CGSize = CGSize(width: 100, height: 150)
        
        NSLayoutConstraint.activate([
            ornamentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ornamentImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenWidth / 3),
            ornamentImageView.widthAnchor.constraint(equalToConstant: ornamentImageViewSize.width),
            ornamentImageView.heightAnchor.constraint(equalToConstant: ornamentImageViewSize.height)
        ])
        
        NSLayoutConstraint.activate([
            presentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenWidth / 3),
            presentImageView.widthAnchor.constraint(equalToConstant: presentImageViewSize.width),
            presentImageView.heightAnchor.constraint(equalToConstant: presentImageViewSize.height)
        ])
        
        NSLayoutConstraint.activate([
            treeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            treeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            treeImageView.widthAnchor.constraint(equalToConstant: treeImageViewSize.width),
            treeImageView.heightAnchor.constraint(equalToConstant: treeImageViewSize.height)
        ])
    }
    
    private func getDimensions(for imageView: UIImageView) -> CGSize {
        var dimensions = CGSize(width: 0, height: 0)
        switch imageView {
        case ornamentImageView:
            if imageView.image == UIImage(named: "ornament1") {
                dimensions = CGSize(width: 100, height: 150)
            } else if imageView.image == UIImage(named: "ornament2") {
                dimensions = CGSize(width: 200, height: 50)
            } else if imageView.image == UIImage(named: "ornament3") {
                dimensions = CGSize(width: 100, height: 150)
            } else {
                print("Invalid image for ornamentImageView")
            }
        case presentImageView:
            if imageView.image == UIImage(named: "present1") {
                dimensions = CGSize(width: 100, height: 100)
            } else if imageView.image == UIImage(named: "present2") {
                dimensions = CGSize(width: 100, height: 100)
            } else if imageView.image == UIImage(named: "present3") {
                dimensions = CGSize(width: 100, height: 100)
            } else {
                print("Invalid image for presentImageView")
            }
        default:
            break
        }
        return dimensions
    }


}

