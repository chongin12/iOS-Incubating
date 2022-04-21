//
//  Size.swift
//  Week2
//
//  Created by 정종인 on 2022/04/22.
//

import Foundation
import UIKit

struct Size {
    struct Area {
        static let large: CGFloat = 30
    }
    struct Margin {
        static let small: CGFloat = 5
        static let medium: CGFloat = 10
    }
    struct Font {
        static let title: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let body: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
}
