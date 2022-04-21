//
//  DetailMemoViewController.swift
//  Week2
//
//  Created by 정종인 on 2022/04/18.
//

import UIKit

class DetailMemoViewController: UIViewController {
    lazy var baseView: UIView = {
        let baseView = UIView()
        
        baseView.backgroundColor = .systemBackground
        
        return baseView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Size.Font.title
        
        return label
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.font = Size.Font.body
        
        return textView
    }()
    
    init(with memo: Memo) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = memo.title
        bodyTextView.text = memo.body
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.navigationItem.title = "메모 상세"
    }
    
    private func setViewHierarchy() {
        self.view.addSubview(baseView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(bodyTextView)
    }
    
    private func setConstraints() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(baseView.safeAreaLayoutGuide).inset(Size.Margin.medium)
            $0.height.equalTo(Size.Area.large)
        }
        
        bodyTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Size.Margin.small)
            $0.leading.trailing.bottom.equalTo(baseView.safeAreaLayoutGuide).inset(Size.Margin.small)
        }
    }

}
