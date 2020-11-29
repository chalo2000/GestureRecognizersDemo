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
    
    func setupViews() {
        ornamentImageView.translatesAutoresizingMaskIntoConstraints = false
        ornamentImageView.image = UIImage(named: "candycane")
        view.addSubview(ornamentImageView)
        
        presentImageView.translatesAutoresizingMaskIntoConstraints = false
        presentImageView.image = UIImage(named: "greenPresent")
        view.addSubview(presentImageView)
        
        treeImageView.translatesAutoresizingMaskIntoConstraints = false
        treeImageView.image = UIImage(named: "tree")
        view.addSubview(treeImageView)
        
    }
    
    func setupConstraints() {
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
    
    // MARK: Actions
    
    /** Sets the `sender` imageView to the next image in our hardcoded order upon tap */
    @objc func swapImage(for sender: UIImageView) {
        // TODO: Implement
    }
    
    /** Moves the `sender` imageView in the direction of panning */
    @objc func moveImage(for sender: UIImageView) {
        // TODO: Implement
    }
    
    /** Scales the `sender` imageView by the amount of pinching */
    @objc func scaleImage(for sender: UIImageView) {
        // TODO: Implement
    }
    
    /** Makes a single copy of the `sender` imageView after pressing for minimumPressDuration */
    @objc func copyImage(for sender: UIImageView) {
        // TODO: Implement
    }
    
    // MARK: Helpers
    
    /** Returns the hardcoded dimensions for the given `imageView` */
    func getDimensions(for imageView: UIImageView) -> CGSize {
        var dimensions = CGSize(width: 0, height: 0)
        switch imageView {
        case ornamentImageView:
            if imageView.image == UIImage(named: "candycane") {
                dimensions = CGSize(width: 50, height: 100)
            } else if imageView.image == UIImage(named: "lights") {
                dimensions = CGSize(width: 200, height: 50)
            } else if imageView.image == UIImage(named: "gingerbread") {
                dimensions = CGSize(width: 100, height: 150)
            } else {
                print("Invalid image for ornamentImageView")
            }
        case presentImageView:
            if imageView.image == UIImage(named: "greenPresent") {
                dimensions = CGSize(width: 100, height: 100)
            } else if imageView.image == UIImage(named: "orangePresent") {
                dimensions = CGSize(width: 100, height: 100)
            } else if imageView.image == UIImage(named: "whitePresent") {
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

