//
//  LoginVC.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/26/24.
//

import UIKit

class LoginVC: UIViewController {
    
    var loginViewModel = LoginViewModel()
    var loggedInUsername: String?
    let userSignedInKey = "userSignedIn"
    
    let stackView: CustomVStackView = {
        let view = CustomVStackView()
        return view
    }()
    
    let imageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageButon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "addUserImage")
//        let imageSize = image?.size ?? CGSize(width: 120, height: 120)
        button.setBackgroundImage(image, for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        return button
    }()
    
    let userNameLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "მომხმარებლის სახელი"
        return label
    }()
    
    let userNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "შეიყვანეთ მომხმარებლის სახელი")
        return textField
    }()
    
    let passwordLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "პაროლი"
        return label
    }()
    
    let passwordtextField: CustomTextField = {
        let textField = CustomTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "შეიყვანეთ პაროლი")
        return textField
    }()
    
    let repeatPasswordLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "გაიმეორეთ პაროლი"
        return label
    }()
    
    let repeatPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "გაიმეორეთ პაროლი")
        return textField
    }()
    
    let signInButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("შესვლა", for: .normal)
        button.isEnabled = true
        return button
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        autoLogin()
    }
    
    // MARK: - SetupUI
    func setupUI() {
        view.addSubview(imageView)
        imageView.addSubview(imageButon)
        view.addSubview(stackView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordtextField)
        stackView.addArrangedSubview(repeatPasswordLabel)
        stackView.addArrangedSubview(repeatPasswordTextField)
        view.addSubview(signInButton)
        setupConstraints()
        addActionTosignInButton()
    }
    
    func setupConstraints() {
        
        imageButon.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
            
            imageButon.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            imageButon.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            imageButon.heightAnchor.constraint(equalToConstant: 130),
            imageButon.widthAnchor.constraint(equalToConstant: 130),
            
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            
            userNameTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordtextField.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor),
            repeatPasswordTextField.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor),
            
            signInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            signInButton.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor),
        ])
    }
    
    // MARK: - goToMainVC
    func goToMainVC() {
        let vc = MainVC()
        navigationController?.pushViewController(vc, animated: true)
        if !isUserSignedIn() {
            showFirstSignInAlert()
            UserDefaults.standard.setValue(true, forKey: userSignedInKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc func imageButtonTapped(button: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - addActionToButtons
    func addActionTosignInButton() {
        signInButton.addAction(UIAction(handler: { _ in
            guard let username = self.userNameTextField.text, !username.isEmpty else {
                let alert = UIAlertController(title: "შეცდომა", message: "გთხოვთ შეიყვანოთ მონაცემები", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "დაბრუნება", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Username is empty")
                return
            }
            
            guard let password = self.passwordtextField.text, !password.isEmpty else {
                let alert = UIAlertController(title: "შეცდომა", message: "გთხოვთ შეიყვანოთ მონაცემები", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "დაბრუნება", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Password is empty")
                return
            }
            
            guard let repeatPassword = self.repeatPasswordTextField.text, !repeatPassword.isEmpty else {
                let alert = UIAlertController(title: "შეცდომა", message: "გთხოვთ შეიყვანოთ მონაცემები", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "დაბრუნება", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Repeat password is empty")
                return
            }
            
            guard password == repeatPassword else {
                let alert = UIAlertController(title: "შეცდომა", message: "პაროლები არ ემთხვევა ერთმანეთს, გთხოვთ ახლიდან სცადოთ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "დაბრუნება", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.loginViewModel.save(username: username, password: password)
            self.goToMainVC()
        }), for: .touchUpInside)
    }
    
    func addActionToImageButton() {
        imageButon.addAction(UIAction(handler: { [weak self] _ in
            self?.imageButtonTapped(button: self?.imageButon ?? UIButton())
        }), for: .touchUpInside)
        
    }
    
    // MARK: - AutoLogin
    func autoLogin() {
        if let savedCredentials = KeyChainService.shared.getSavedCredentials() {
            print("Auto-Login Successful!")
            loggedInUsername = savedCredentials.username
            if !isUserSignedIn() {
                UserDefaults.standard.setValue(true, forKey: userSignedInKey)
                UserDefaults.standard.synchronize()
                goToMainVC()
            } else {
                goToMainVC()
            }
        } else {
            print("No saved credentials found.")
        }
    }
    
    func isUserSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: userSignedInKey)
    }
    func showFirstSignInAlert() {
        let alert = UIAlertController(title: "Welcome!", message: "Thank you for signing in Countries app.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

