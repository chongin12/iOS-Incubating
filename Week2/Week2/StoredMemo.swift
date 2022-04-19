//
//  StoredMemo.swift
//  Week2
//
//  Created by 정종인 on 2022/04/19.
//

import Foundation

class StoredMemo {
    static let shared = StoredMemo()
    
    var memos: [Memo] = [Memo(title: "asdf", body: "qwer")]
}

struct Memo {
    var title: String
    var body: String
}
