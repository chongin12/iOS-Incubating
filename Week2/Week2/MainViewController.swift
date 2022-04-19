//
//  ViewController.swift
//  Week2
//
//  Created by 정종인 on 2022/04/18.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private lazy var baseView: UIView = {
        let baseView = UIView()
        
        baseView.backgroundColor = .systemBackground
        
        return baseView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        
        return tableView
    }()
    
    private let reuseIdentifier = "cell"
    
    private lazy var tableViewCell: UITableViewCell = {
        let tableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        return tableViewCell
    }()
    
    private lazy var createMemoBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushCreateMemoViewController(_:)))
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayouts()
        setNavigationItem()
        setTableViewDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
        registerCell()
    }
    
    private func setNavigationItem() {
        self.navigationItem.title = "메모 목록"
        self.navigationItem.rightBarButtonItem = createMemoBarButtonItem
    }
    
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setViewHierarchy() {
        self.view.addSubview(baseView)
        baseView.addSubview(tableView)
    }
    
    private func setConstraints() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc
    private func pushCreateMemoViewController(_ sender: UIBarButtonItem) {
        let nextViewController = CreateMemoViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else { return UITableViewCell() }
        
        let memo = StoredMemo.shared.memos[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = memo.title
        content.secondaryText = memo.body

        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoredMemo.shared.memos.count
    }
}
