//
//  CustomScrollView.swift
//  Week1
//
//  Created by 정종인 on 2022/04/13.
//

import UIKit

class CustomScrollView: UIScrollView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
