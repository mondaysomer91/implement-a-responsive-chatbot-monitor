import UIKit
import CoreGraphics

class ChatbotMonitor: UIViewController {
    // MARK: - Properties
    let chatbotView = UIView()
    let messageTextField = UITextField()
    let sendButton = UIButton()
    let messagesTableView = UITableView()
    var messages: [String] = []

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .white
        setupChatbotView()
        setupMessageTextField()
        setupSendButton()
        setupMessagesTableView()
    }

    // MARK: - Setup Chatbot View
    func setupChatbotView() {
        chatbotView.backgroundColor = .lightGray
        chatbotView.layer.cornerRadius = 10
        view.addSubview(chatbotView)
        chatbotView.translatesAutoresizingMaskIntoConstraints = false
        chatbotView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        chatbotView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        chatbotView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        chatbotView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    // MARK: - Setup Message Text Field
    func setupMessageTextField() {
        messageTextField.placeholder = "Type a message..."
        messageTextField.backgroundColor = .white
        messageTextField.layer.cornerRadius = 10
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(messageTextField)
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.topAnchor.constraint(equalTo: chatbotView.bottomAnchor, constant: 20).isActive = true
        messageTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        messageTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }

    // MARK: - Setup Send Button
    func setupSendButton() {
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.layer.cornerRadius = 10
        view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: messageTextField.bottomAnchor, constant: 10).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }

    // MARK: - Setup Messages Table View
    func setupMessagesTableView() {
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
        view.addSubview(messagesTableView)
        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        messagesTableView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 20).isActive = true
        messagesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        messagesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }

    // MARK: - Send Button Tapped
    @objc func sendButtonTapped() {
        guard let message = messageTextField.text, !message.isEmpty else { return }
        messages.append(message)
        messageTextField.text = nil
        messagesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ChatbotMonitor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatbotMonitor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}