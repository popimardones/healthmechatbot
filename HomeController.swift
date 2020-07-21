//
//  HomeController.swift

import UIKit
import Firebase

class HomeController: UIViewController {
    
    let fakeHomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fakeHome")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //to have the same aspect ratio, so it stays proportional
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        setupNavigationItems()
        checkIfUserIsLoggedIn()
        setUpFakeImage()
    }
    fileprivate func setupNavigationItems() {
        navigationItem.title = "HealthMe"
        let image = UIImage(systemName: "text.bubble.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleChatbot))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    fileprivate func setUpFakeImage() {
        view.addSubview(fakeHomeImageView)
        fakeHomeImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fakeHomeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        fakeHomeImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        fakeHomeImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @objc func handleChatbot() {
        let chatbotController = ChatbotController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(chatbotController, animated: true)
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
            if Auth.auth().currentUser?.uid == nil {
                perform(#selector(handleLogout), with: nil, afterDelay: 0)
            } else {
                print("is logged in")
            }
        }
    
}
