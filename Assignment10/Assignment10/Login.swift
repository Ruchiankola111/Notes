//
//  Login.swift
//  Ass10NotesApp
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Login: UIViewController {
    
    public  let noname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .orange
        label.text = "My Notes"
        return label
    }()
    public  let lname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.textColor = .orange
        label.text = "Login"
        return label
    }()
    
    private let nameTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.textColor = .orange
        textField.layer.borderColor = UIColor.orange.cgColor
        return  textField
    }()
    private let pwdTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.textColor = .orange
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.isSecureTextEntry = true
        return  textField
    }()
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:  UIImage(named: "bgimg")!)
        
        view.addSubview(loginButton)
        view.addSubview(noname)
        view.addSubview(lname)
        view.addSubview(nameTextField)
        view.addSubview(pwdTextField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noname.frame = CGRect(x: 100, y: 130, width: 300, height: 43)
        lname.frame  = CGRect(x: 140, y: 240, width: 300, height: 43)
        nameTextField.frame = CGRect(x: 40, y: 330, width: view.width - 80, height: 43)
        pwdTextField.frame = CGRect(x: 40, y: nameTextField.bottom + 20, width: view.width - 80, height: 43)
        loginButton.frame = CGRect(x: 40, y: pwdTextField.bottom + 50, width: view.width - 80, height: 43)
    }
    
    @objc private func loginTapped() {
        UserDefaults.standard.setValue("Ruchita", forKey: "username")
        let vc = FileList()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
