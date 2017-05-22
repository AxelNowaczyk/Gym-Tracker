//
//  UIView+KeybordHandling.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 06/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

extension UIView {
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func unbindFromKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc
    func keyboardWillChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        moveFrameIfNeeded(delta: deltaY, duration: duration, curve: curve)
    }
    
    private func moveFrameIfNeeded(delta: CGFloat, duration: Double, curve: UInt) {
        var delta = delta
        guard delta != 0 else {
            return
        }
        let tabBarHeight = (UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController)?.tabBar.bounds.size.height ?? 0
        
        if delta < 0 {
            delta += tabBarHeight
        } else {
            delta -= tabBarHeight
        }
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += delta
        })
    }
}
