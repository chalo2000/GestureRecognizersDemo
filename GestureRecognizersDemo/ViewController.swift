//
//  ViewController.swift
//  GestureRecognizersDemo
//
//  Created by Gonzalo Gonzalez on 11/27/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: UI Elements
    let ornamentImageView: UIImageView = UIImageView()
    let presentImageView: UIImageView = UIImageView()
    let treeImageView: UIImageView = UIImageView()
    
    // MARK: Variables
    var initialOrigin: CGPoint!
    
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
        ornamentImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(swapImage(for:))))
        ornamentImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveImage(for:))))
        ornamentImageView.isUserInteractionEnabled = true
        view.addSubview(ornamentImageView)
        
        presentImageView.translatesAutoresizingMaskIntoConstraints = false
        presentImageView.image = UIImage(named: "greenPresent")
        presentImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(swapImage(for:))))
        presentImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveImage(for:))))
        presentImageView.isUserInteractionEnabled = true
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
        
        ornamentImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(screenWidth / 3)
            make.width.equalTo(ornamentImageViewSize.width)
            make.height.equalTo(ornamentImageViewSize.height)
        }
        
        presentImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(screenWidth / 3)
            make.width.equalTo(presentImageViewSize.width)
            make.height.equalTo(presentImageViewSize.height)
        }
        
        treeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(treeImageViewSize.width)
            make.height.equalTo(treeImageViewSize.height)
        }
    }
    
    @objc func swapImage(for sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as! UIImageView? else { return }
        switch imageView {
        case ornamentImageView:
            if imageView.image == UIImage(named: "candycane") {
                imageView.image = UIImage(named: "lights")
            } else if imageView.image == UIImage(named: "lights") {
                imageView.image = UIImage(named: "gingerbread")
            } else if imageView.image == UIImage(named: "gingerbread") {
                imageView.image = UIImage(named: "candycane")
            } else {
                print("Invalid image for ornamentImageView")
            }
        case presentImageView:
            if imageView.image == UIImage(named: "greenPresent") {
                imageView.image = UIImage(named: "orangePresent")
            } else if imageView.image == UIImage(named: "orangePresent") {
                imageView.image = UIImage(named: "whitePresent")
            } else if imageView.image == UIImage(named: "whitePresent") {
                imageView.image = UIImage(named: "greenPresent")
            } else {
                print("Invalid image for presentImageView")
            }
        default:
            break
        }
        
        let imageViewSize: CGSize = getDimensions(for: imageView)
        imageView.snp.updateConstraints { make in
            make.width.equalTo(imageViewSize.width)
            make.height.equalTo(imageViewSize.height)
        }
    }
    
    @objc func moveImage(for sender: UIPanGestureRecognizer) {
        guard let imageView = sender.view as! UIImageView? else { return }

        let translation = sender.translation(in: imageView.superview)
        if sender.state == .began {
            initialOrigin = imageView.frame.origin
        }
        
        if sender.state != .cancelled {
           let newCenter = CGPoint(x: initialOrigin.x + translation.x, y: initialOrigin.y + translation.y)
           imageView.frame.origin = newCenter
        }
        else {
           imageView.frame.origin = initialOrigin
        }
        
        if sender.state == .ended {
            imageView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(initialOrigin.x + translation.x)
                make.top.equalToSuperview().offset(initialOrigin.y + translation.y)
                make.width.equalTo(imageView.frame.width)
                make.height.equalTo(imageView.frame.height)
            }
        }
    }
    
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

