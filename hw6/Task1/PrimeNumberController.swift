import UIKit
import SnapKit

class PrimeNumberController: UIViewController {
    
    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.backgroundColor = .black
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .white
        return textView
    }()
    
    private let checkPrimesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check Primes", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(resultTextView)
        view.addSubview(checkPrimesButton)
        
        checkPrimesButton.addTarget(self, action: #selector(checkPrimesButtonTapped), for: .touchUpInside)
        
        resultTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-90)
            make.height.equalTo(600)
        }
        
        checkPrimesButton.snp.makeConstraints { make in
            make.top.equalTo(resultTextView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
    }
    
    let primeChecker = PrimeNumberChecker()
    
    @objc private func checkPrimesButtonTapped() {
        let numbers = Array(1...10000)
        let numberOfTasks = 4
        
        primeChecker.findPrimesConcurrently(from: numbers, numberOfTasks: numberOfTasks) { primes in
            DispatchQueue.main.async {
                self.resultTextView.text = "Prime numbers:\n" + primes.map { String($0) }.joined(separator: "\n")
            }
        }
    }
}
