//
//  ImageGesture.swift
//  Assignment9
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ImageGesture: UIViewController {

    private let v : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 50, y: 50, width: 270, height: 570)
        view.backgroundColor = .lightText
        return view
    }()
    
    private let ipick : UIImagePickerController = {
        let i = UIImagePickerController()
        i.allowsEditing = true
        return i
    }()
    
    private let img : UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        view.addSubview(v)
        
        v.addSubview(img)
        ipick.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(justTap))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        v.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(justPinch))
        v.addGestureRecognizer(pinchGesture)
        
        let rotataionGesture = UIRotationGestureRecognizer(target: self, action: #selector(JustRotate))
        v.addGestureRecognizer(rotataionGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(justSwipe))
        leftSwipe.direction = .left
        v.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(justSwipe))
        rightSwipe.direction = .right
        v.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(justSwipe))
        upSwipe.direction = .up
        v.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(justSwipe))
        downSwipe.direction = .down
        v.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(justPan))
        v.addGestureRecognizer(panGesture)    }
    
    override func viewDidLayoutSubviews() {
        img.frame = CGRect(x: 10 , y: 10, width: 250, height: 550)
    }
}

extension ImageGesture: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectImg = info[.editedImage] as? UIImage {
            img.image = selectImg
        }
        
        picker.dismiss(animated: true)
    }
}

extension ImageGesture {
    @objc private func justTap (gesture: UITapGestureRecognizer) {
        ipick.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.ipick, animated: true)
        }
    }
    
    @objc private func justPinch (gesture: UIPinchGestureRecognizer) {
        img.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    @objc private func JustRotate (gesture: UIRotationGestureRecognizer) {
        img.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func justSwipe (gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            UIView.animate(withDuration: 0.5) {
                self.img.frame = CGRect(x: self.img.frame.origin.x - 40,
                                           y: self.img.frame.origin.y, width: 250, height: 550)
            }
        }
        else if gesture.direction == .right {
            UIView.animate(withDuration: 0.5) {
                self.img.frame = CGRect(x: self.img.frame.origin.x + 40,
                                           y: self.img.frame.origin.y, width: 250, height: 550)
            }
        }
        else if gesture.direction == .up {
            UIView.animate(withDuration: 0.5) {
                self.img.frame = CGRect(x: self.img.frame.origin.x,
                                           y: self.img.frame.origin.y - 40, width: 250, height: 550)
            }
        }
        else if gesture.direction == .down {
            UIView.animate(withDuration: 0.5) {
                self.img.frame = CGRect(x: self.img.frame.origin.x,
                                           y: self.img.frame.origin.y + 40, width: 250, height: 550)
            }
        }
    }
    
    @objc private func justPan (gesture: UIPanGestureRecognizer) {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        
        img.center = CGPoint(x: x, y: y)
    }}
