//
//  Extensions.swift
//  Week2
//
//  Created by 정종인 on 2022/05/09.
//

import Foundation
import UIKit

extension UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.setViewHeight(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.setViewHeight(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func setViewHeight(notification: NSNotification) {
        guard let viewHeight = self.view.window?.frame.size.height else { return }
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let screenHeight = UIScreen.main.bounds.height
            if notification.name == UIResponder.keyboardWillShowNotification {
                if(screenHeight == viewHeight) {
                    self.view.window?.frame.size.height -= keyboardHeight
                }
            } else {
                self.view.window?.frame.size.height = screenHeight
            }
        }
    }
}
