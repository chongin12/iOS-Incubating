//
//  ViewController.swift
//  Week1
//
//  Created by 정종인 on 2022/04/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {


    lazy var textField1: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "숫자1 입력"
        
        return textField
    }()
    
    lazy var textField2: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "숫자2 입력"
        
        return textField
    }()
    
    lazy var performPlusButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("더하기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        button.tag = Tag.plus
        
        return button
    }()
    
    lazy var performMinusButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemCyan
        button.setTitle("빼기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        button.tag = Tag.minus
        
        return button
    }()
    
    lazy var performMultipleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBrown
        button.setTitle("곱하기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        button.tag = Tag.multiple
        
        return button
    }()
    
    lazy var performDivideButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemIndigo
        button.setTitle("나누기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        button.tag = Tag.divide
        
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeViews()
        makeLogics()
    }
    
    private func makeViews() {
        self.view.addSubview(textField1)
        textField1.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.large)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
        
        self.view.addSubview(textField2)
        textField2.snp.makeConstraints {
            $0.top.equalTo(textField1.snp.bottom).offset(Size.Margin.large)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
        
        self.view.addSubview(performPlusButton)
        performPlusButton.snp.makeConstraints{
            $0.top.equalTo(textField2.snp.bottom).offset(Size.Margin.large)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
        
        self.view.addSubview(performMinusButton)
        performMinusButton.snp.makeConstraints{
            $0.top.equalTo(performPlusButton.snp.bottom).offset(Size.Margin.small)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
        
        self.view.addSubview(performMultipleButton)
        performMultipleButton.snp.makeConstraints{
            $0.top.equalTo(performMinusButton.snp.bottom).offset(Size.Margin.small)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
        
        self.view.addSubview(performDivideButton)
        performDivideButton.snp.makeConstraints{
            $0.top.equalTo(performMultipleButton.snp.bottom).offset(Size.Margin.small)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
        
        self.view.addSubview(resultLabel)
        resultLabel.text = ""
        resultLabel.snp.makeConstraints{
            $0.top.equalTo(performDivideButton.snp.bottom).offset(Size.Margin.large)
            $0.height.equalTo(Size.Area.large)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Size.Margin.small)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Size.Margin.small)
        }
    }
    
    private func makeLogics() {
        performPlusButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        performMinusButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        performMultipleButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        performDivideButton.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
    }
    
    @objc
    func onTapButton(_ button: UIButton) {
        print(button.tag)
        // 1. textfield 변환 후 오류 식별
        guard let text1 = textField1.text, let text2 = textField2.text else {
            resultLabel.text = ErrorMessage.unknown
            return
        }
        
        if text1 == "" || text2 == "" {
            resultLabel.text = ErrorMessage.emptyInput
            return
        }
        
        guard let num1 = Int(text1), let num2 = Int(text2) else {
            resultLabel.text = ErrorMessage.invalidInput
            return
        }
        
        var resultText = ""
        switch button.tag {
        case 0:
            resultText = "\(num1) + \(num2) = \(num1+num2)"
        case 1:
            resultText = "\(num1) - \(num2) = \(num1-num2)"
        case 2:
            resultText = "\(num1) * \(num2) = \(num1*num2)"
        case 3:
            if num2 == 0 {
                resultText = ErrorMessage.divideByZero
            } else {
                resultText = "\(num1) / \(num2) = \(num1/num2)"
            }
        default:
            resultText = ErrorMessage.unknown
        }
        
        resultLabel.text = resultText
        // 2. result에 값 출력
    }
}

struct Size {
    struct Margin {
        static let small = 15
        static let large = 25
    }
    
    struct Area {
        static let large = 45
    }
}

struct Tag {
    static let plus = 0
    static let minus = 1
    static let multiple = 2
    static let divide = 3
}

struct ErrorMessage {
    static let invalidInput = "값이 잘못되었습니다."
    static let emptyInput = "값을 입력해주세요"
    static let divideByZero = "0으로 나눌 수 없습니다."
    static let unknown = "알 수 없는 오류입니다"
}
