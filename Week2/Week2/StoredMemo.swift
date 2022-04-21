//
//  StoredMemo.swift
//  Week2
//
//  Created by 정종인 on 2022/04/19.
//

import Foundation

class StoredMemo {
    static let shared = StoredMemo()
    
    var memos: [Memo] = []
}

struct Memo {
    private var titleRawValue: String = ""
    private var bodyRawValue: String = ""
    
    var title: String {
        get {
            return titleRawValue == "" ? "기본 제목" : titleRawValue
        }
        set {
            titleRawValue = newValue
        }
    }
    
    var body: String {
        get {
            return bodyRawValue == "" ? "기본 내용" : bodyRawValue
        }
        set {
            bodyRawValue = newValue
        }
    }
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
