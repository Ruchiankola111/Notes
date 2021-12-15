//
//  NewFile.swift
//  Ass10NotesApp
//
//  Created by DCS on 13/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewFile: UIViewController {
    
    public let nameTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 1
        textField.textColor = UIColor(red: 0.17, green: 0.12, blue: 0.08, alpha: 1.00)
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.placeholder = "Enter File Name"
        return  textField
    }()
    
    public let contentTextView:UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.layer.borderColor = UIColor.orange.cgColor
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        return textView
    }()
    
    private let saveButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 6
        return button
    }()
    @objc private func saveNote() {
        let name = nameTextField.text!
        let content = contentTextView.text!
        
        let filePath = FMS.getDocDir().appendingPathComponent("\(name).text")
        
        do {
            try content.write(to: filePath, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
        
        let vc = FileList()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameTextField)
        view.addSubview(contentTextView)
        view.addSubview(saveButton)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        let name = nameTextField.text!
        do {
            
            let filePath = FMS.getDocDir().appendingPathComponent("\(name).txt")
            let fetchedConetent = try String(contentsOf: filePath)
            print(fetchedConetent)
        }catch{
            print(error)
        }
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameTextField.frame = CGRect(x: 10, y: 100, width: view.width - 20, height: 40)
        contentTextView.frame = CGRect(x: 10, y: nameTextField.bottom + 20, width: view.width - 20, height: 420)
        saveButton.frame = CGRect(x: 40, y: contentTextView.bottom + 20, width: view.width - 80, height: 40)
    }
}
