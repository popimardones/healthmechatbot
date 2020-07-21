//
//  ChatInputContainerView.swift

import UIKit

class ChatInputContainerView: UIView, UITextFieldDelegate {
        
    weak var chatbotController: ChatbotController? {
        didSet {
            sendButton.addTarget(chatbotController, action: #selector(ChatbotController.handleSend), for: .touchUpInside)
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var chatbotResumenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 137, b: 249)
        button.setTitle("Ir al resumen del chatbot", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleResumenChatbot), for: .touchUpInside)
        return button
    }()
    
    @objc func handleResumenChatbot() {
        
    }
    
    lazy var chatbotDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Finish Chatbot", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleFinishChatbot), for: .touchUpInside)
        return button
    }()
    
    static let updateFinishChatbotNotificationName = NSNotification.Name(rawValue: "updateFinishChatbot")
    @objc func handleFinishChatbot() {
        //post notification
        NotificationCenter.default.post(name: ChatInputContainerView.updateFinishChatbotNotificationName, object: nil)
    }
        
    let sendButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(self.inputTextField)
        //x,y,w,h
        self.inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorLineView)
        //x,y,w,h
        separatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateInputContainerView), name: ChatbotController.updateInputContainerViewNotificationName, object: nil)

    }
    
    @objc func handleUpdateInputContainerView(){
        print("inside chatinputcontainerview, inside handleUpdateInputContainerView")
        inputTextField.removeFromSuperview()
        sendButton.removeFromSuperview()
        addSubview(chatbotDoneButton)
        chatbotDoneButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        chatbotDoneButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chatbotDoneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        chatbotDoneButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatbotController?.handleSend()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
