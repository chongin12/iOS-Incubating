//
//  ViewController.swift
//  Week1
//
//  Created by 정종인 on 2022/04/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = CustomScrollView()
        
        scrollView.canCancelContentTouches = true
        
        return scrollView
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = CGFloat(Size.Margin.large)
        
        return stackView
    }()

    lazy var textField1: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "숫자1 입력"
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var textField2: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "숫자2 입력"
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = CGFloat(Size.Margin.small)
        
        return stackView
    }()
    
    lazy var performPlusButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("더하기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    lazy var performMinusButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemCyan
        button.setTitle("빼기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    lazy var performMultipleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBrown
        button.setTitle("곱하기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    lazy var performDivideButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemIndigo
        button.setTitle("나누기 수행", for: .normal)
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.text = ""
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayouts()
        addTargetsOnButton()
        setKeyboardObserver()
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.view.addSubview(baseView)
        baseView.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        [performPlusButton, performMinusButton, performMultipleButton, performDivideButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        [textField1, textField2, buttonStackView, resultLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraints() {
        baseView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(baseView.safeAreaLayoutGuide).inset(Size.Margin.small)
            
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        [textField1, textField2, performPlusButton, performMinusButton, performMultipleButton, performDivideButton, resultLabel].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(Size.Area.large)
            }
        }
        
        
    }
    
    private func addTargetsOnButton() {
        [performPlusButton, performMinusButton, performMultipleButton, performDivideButton].forEach {
            $0.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        }
    }
    
    @objc
    func onTapButton(_ button: UIButton) {
        var resultText = ""
        do {
            let tuple: (Int,Int) = try getResult()
            switch button {
            case performPlusButton:
                resultText = "\(tuple.0) + \(tuple.1) = \(tuple.0+tuple.1)"
            case performMinusButton:
                resultText = "\(tuple.0) - \(tuple.1) = \(tuple.0-tuple.1)"
            case performMultipleButton:
                resultText = "\(tuple.0) * \(tuple.1) = \(tuple.0*tuple.1)"
            case performDivideButton:
                if tuple.1 == 0 { throw ErrorMessage.divideByZero }
                resultText = "\(tuple.0) / \(tuple.1) = \(tuple.0/tuple.1)"
            default:
                throw ErrorMessage.unknown
            }
        } catch ErrorMessage.invalidInput {
            resultText = ErrorMessage.invalidInput.rawValue
        } catch ErrorMessage.emptyInput {
            resultText = ErrorMessage.emptyInput.rawValue
        } catch ErrorMessage.divideByZero {
            resultText = ErrorMessage.divideByZero.rawValue
        } catch {
            resultText = ErrorMessage.unknown.rawValue
        }
        
        resultLabel.text = resultText
    }
    
    private func getResult() throws -> (Int,Int) {
        guard let text1 = textField1.text, let text2 = textField2.text else {
            throw ErrorMessage.unknown
        }
        
        if text1.isEmpty || text2.isEmpty {
            throw ErrorMessage.emptyInput
        }
        
        guard let num1 = Int(text1), let num2 = Int(text2) else {
            throw ErrorMessage.invalidInput
        }
        
        return (num1,num2)
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
    
    enum ErrorMessage: String, Error {
        case invalidInput = "값이 잘못되었습니다."
        case emptyInput = "값을 입력해주세요"
        case divideByZero = "0으로 나눌 수 없습니다."
        case unknown = "알 수 없는 오류입니다"
    }

}
