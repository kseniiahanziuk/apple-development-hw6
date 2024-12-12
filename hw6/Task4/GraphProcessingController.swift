import UIKit

class GraphProcessingController: UIViewController {

    var stackView: UIStackView!
    var taskLabels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        graph1()
        graph2()
    }
    
    func setupUI() {
        stackView = UIStackView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 600))
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        view.addSubview(stackView)
        
        let totalTasks = 16
        
        for index in 0..<totalTasks {
            let label = UILabel()
            label.text = "Task \(index + 1): Not Started"
            label.numberOfLines = 0
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16)
            taskLabels.append(label)
            stackView.addArrangedSubview(label)
        }
    }
    
    func updateTaskStatus(taskIndex: Int, status: String, emoji: String) {
        DispatchQueue.main.async {
            if taskIndex < self.taskLabels.count {
                let label = self.taskLabels[taskIndex]
                label.text = "Task \(taskIndex + 1): \(status) \(emoji)"
            }
        }
    }
    
    func graph1() {
        let group = DispatchGroup()

        performTask(named: "A", emoji: "🍎", taskIndex: 0, group: group)
        performTask(named: "B", emoji: "🍌", taskIndex: 1, group: group, dependencies: [0])
        performTask(named: "C", emoji: "🍒", taskIndex: 2, group: group, dependencies: [1])
        performTask(named: "D", emoji: "🐬", taskIndex: 3, group: group, dependencies: [0])
        performTask(named: "E", emoji: "🌏", taskIndex: 4, group: group, dependencies: [3])
        performTask(named: "F", emoji: "🐡", taskIndex: 5, group: group, dependencies: [4])

        group.notify(queue: .main) {
            print("Graph 1 tasks completed.")
        }
    }
    
    func graph2() {
        let group = DispatchGroup()

        performTask(named: "A", emoji: "🍏", taskIndex: 6, group: group)
        performTask(named: "B", emoji: "🦴", taskIndex: 7, group: group, dependencies: [6])
        performTask(named: "C", emoji: "🍫", taskIndex: 8, group: group, dependencies: [7])
        performTask(named: "D", emoji: "🐶", taskIndex: 9, group: group, dependencies: [8])
        performTask(named: "E", emoji: "🐘", taskIndex: 10, group: group, dependencies: [9])
        performTask(named: "F", emoji: "🔥", taskIndex: 11, group: group, dependencies: [8])
        performTask(named: "G", emoji: "🍇", taskIndex: 12, group: group, dependencies: [7])
        performTask(named: "H", emoji: "🌭", taskIndex: 13, group: group, dependencies: [8])
        performTask(named: "I", emoji: "🧊", taskIndex: 14, group: group, dependencies: [9])
        performTask(named: "J", emoji: "⚱️", taskIndex: 15, group: group, dependencies: [10])

        group.notify(queue: .main) {
            print("Graph 2 tasks completed.")
        }
    }
    
    func performTask(named taskName: String, emoji: String, taskIndex: Int, group: DispatchGroup,
                     dependencies: [Int] = []) {
        group.enter()

        let dependencyGroup = DispatchGroup()
        for dependencyIndex in dependencies {
            dependencyGroup.enter()
            DispatchQueue.global().async {
                self.updateTaskStatus(taskIndex: dependencyIndex, status: "Completed", emoji: "⌛")
                dependencyGroup.leave()
            }
        }

        dependencyGroup.notify(queue: .global()) {
            let sleepTime = Int.random(in: 1...3)
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(sleepTime)) {
                self.updateTaskStatus(taskIndex: taskIndex, status: "Completed", emoji: emoji)
                group.leave()
            }
            
            self.updateTaskStatus(taskIndex: taskIndex, status: "Started", emoji: emoji)
        }
    }
}
