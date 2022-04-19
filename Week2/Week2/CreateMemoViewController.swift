//
//  CreateMemoViewController.swift
//  Week2
//
//  Created by 정종인 on 2022/04/18.
//

import UIKit

class CreateMemoViewController: UIViewController {
    lazy var baseView: UIView = {
        let baseView = UIView()
        
        baseView.backgroundColor = .systemBackground
        
        return baseView
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "제목 입력"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        
        textView.backgroundColor = .systemGray6
        
        return textView
    }()
    
    lazy var doneBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishCreatingMemo(_:)))
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayouts()
        setNavigationItem()
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setNavigationItem() {
        self.navigationItem.title = "메모 작성"
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    private func setViewHierarchy() {
        self.view.addSubview(baseView)
        baseView.addSubview(titleTextField)
        baseView.addSubview(bodyTextView)
    }
    
    private func setConstraints() {
        baseView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(baseView.safeAreaLayoutGuide).inset(Size.Margin.small)
            $0.height.equalTo(Size.Area.large)
        }
        
        bodyTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(Size.Margin.small)
            $0.leading.trailing.bottom.equalTo(baseView.safeAreaLayoutGuide).inset(Size.Margin.small)
        }
    }
    
    @objc
    private func finishCreatingMemo(_ sender: UIBarButtonItem) {
        let newMemo: Memo = Memo(title: titleTextField.text ?? "", body: bodyTextView.text ?? "")
        
        StoredMemo.shared.memos.append(newMemo)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    struct Size {
        struct Area {
            static let large: CGFloat = 30
        }
        struct Margin {
            static let small: CGFloat = 5
        }
    }
}
