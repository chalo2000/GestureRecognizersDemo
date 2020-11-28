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
    
    // MARK: Constants
    
    enum Decoration: Int {
        case ornament = 1
        case present = 2
    }
    
    // MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        ornamentImageView.image = UIImage(named: "candycane")
        setupGestureRecognizers(for: ornamentImageView)
        ornamentImageView.tag = Decoration.ornament.rawValue
        view.addSubview(ornamentImageView)
        
        presentImageView.image = UIImage(named: "greenPresent")
        setupGestureRecognizers(for: presentImageView)
        presentImageView.tag = Decoration.present.rawValue
        view.addSubview(presentImageView)
        
        treeImageView.image = UIImage(named: "tree")
        treeImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveImage(for:))))
        treeImageView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(scaleImage(for:))))
        treeImageView.isUserInteractionEnabled = true
        view.addSubview(treeImageView)
        view.sendSubviewToBack(treeImageView)
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
    
    // MARK: Actions
    
    /** Sets the `sender` imageView to the next image in our hardcoded order upon tap */
    @objc func swapImage(for sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as! UIImageView? else { return }
        switch imageView.tag {
        case Decoration.ornament.rawValue:
            if imageView.image == UIImage(named: "candycane") {
                imageView.image = UIImage(named: "lights")
            } else if imageView.image == UIImage(named: "lights") {
                imageView.image = UIImage(named: "gingerbread")
            } else if imageView.image == UIImage(named: "gingerbread") {
                imageView.image = UIImage(named: "candycane")
            } else {
                print("Invalid image for ornamentImageView")
            }
        case Decoration.present.rawValue:
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
    
    /** Moves the `sender` imageView in the direction of panning */
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
    
    /** Scales the `sender` imageView by the amount of pinching */
    @objc func scaleImage(for sender: UIPinchGestureRecognizer) {
        guard let imageView = sender.view as! UIImageView? else { return }
        if sender.state == .began || sender.state == .changed {
            imageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        }
        
        if sender.state == .ended {
            imageView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(imageView.frame.minX)
                make.top.equalToSuperview().offset(imageView.frame.minY)
                make.width.equalTo(imageView.frame.width)
                make.height.equalTo(imageView.frame.height)
            }
            imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    /** Makes a single copy of the `sender` imageView after pressing for minimumPressDuration */
    @objc func copyImage(for sender: UILongPressGestureRecognizer) {
        guard let imageView = sender.view as! UIImageView? else { return }
        let newImageView = UIImageView()
        newImageView.image = imageView.image
        setupGestureRecognizers(for: newImageView)
        newImageView.tag = imageView.tag
        view.addSubview(newImageView)
        
        newImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(imageView.frame.minX)
            make.top.equalToSuperview().offset(imageView.frame.minY)
            make.width.equalTo(imageView.frame.width)
            make.height.equalTo(imageView.frame.height)
        }
        
        print("New image created")
    }
    
    // MARK: Helpers
    
    /** Returns the hardcoded dimensions for the given `imageView` */
    func getDimensions(for imageView: UIImageView) -> CGSize {
        var dimensions = CGSize(width: 0, height: 0)
        switch imageView.tag {
        case Decoration.ornament.rawValue:
            if imageView.image == UIImage(named: "candycane") {
                dimensions = CGSize(width: 50, height: 100)
            } else if imageView.image == UIImage(named: "lights") {
                dimensions = CGSize(width: 200, height: 50)
            } else if imageView.image == UIImage(named: "gingerbread") {
                dimensions = CGSize(width: 100, height: 150)
            } else {
                print("Invalid image for ornamentImageView")
            }
        case Decoration.present.rawValue:
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
    
    func setupGestureRecognizers(for imageView: UIImageView) {
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(swapImage(for:))))
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveImage(for:))))
        imageView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(scaleImage(for:))))
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(copyImage(for:)))
        longPressGestureRecognizer.minimumPressDuration = 1
        imageView.addGestureRecognizer(longPressGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }
    
}

