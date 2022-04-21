//
//  CreateMemoViewController.swift
//  Week2
//
//  Created by 정종인 on 2022/04/18.
//

import UIKit

class CreateMemoViewController: UIViewController {
    let titlePlaceHolder = "제목 입력"
    let bodyPlaceHolder = "내용 입력"
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        
        baseView.backgroundColor = .systemBackground
        
        return baseView
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = titlePlaceHolder
        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        
        textView.backgroundColor = .systemGray6
        textView.delegate = self
        textView.text = bodyPlaceHolder
        textView.textColor = .systemGray2
        
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
        setKeyboardObserver()
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
}

extension UIViewController {
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.size.height -= keyboardHeight
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.size.height += keyboardHeight
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object:nil)
        }
    }
}

extension CreateMemoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newTextLength = text.count + string.count - range.length
        return newTextLength <= 11
    }
}

extension CreateMemoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == bodyPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = bodyPlaceHolder
            textView.textColor = .systemGray2
        }
    }
}
