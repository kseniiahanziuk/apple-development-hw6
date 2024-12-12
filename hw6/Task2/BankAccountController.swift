import UIKit
import SnapKit

class BankAccountController: UIViewController {
    
    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.backgroundColor = .black
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .white
        textView.text = "Output will appear in console. Sorry, I'm too lazy:("
        return textView
    }()
    
    private let simulateRaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Race Condition", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private let simulateThreadSafeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Thread-Safe Withdrawals", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(resultTextView)
        view.addSubview(simulateRaceButton)
        view.addSubview(simulateThreadSafeButton)
        
        simulateRaceButton.addTarget(self, action: #selector(simulateRaceConditionButtonTapped), for: .touchUpInside)
        simulateThreadSafeButton.addTarget(self, action: #selector(simulateThreadSafeWithdrawalsButtonTapped),
                                           for: .touchUpInside)
        
        resultTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(200)
        }
        
        simulateRaceButton.snp.makeConstraints { make in
            make.top.equalTo(resultTextView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
        
        simulateThreadSafeButton.snp.makeConstraints { make in
            make.top.equalTo(simulateRaceButton.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func simulateRaceConditionButtonTapped() {
        simulateRaceCondition()
    }
        
    @objc func simulateThreadSafeWithdrawalsButtonTapped() {
        simulateThreadSafeWithdrawals()
    }
}
