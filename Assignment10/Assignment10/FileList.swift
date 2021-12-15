//
//  FileList.swift
//  Ass10NotesApp
//
//  Created by DCS on 13/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class FileList: UIViewController {
    
    private var FileArray = [String]()
    private let FileTableView = UITableView()
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.text=""
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        return label
    }()
    
    private let logoutButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 7
        return button
    }()
    @objc private func logoutTapped() {
        UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }
    private let AddNewButton:UIButton = {
        let button=UIButton()
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 18
        return button
    }()
    @objc func handleClick() {
        print("add called")
        let vc = NewFile()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        view.addSubview(FileTableView)
        setupTableView()
        view.addSubview(AddNewButton)
        view.addSubview(logoutButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        checkAuth()
        
        FileArray = []
        
        for f1 in FMS.getfile()
        {
            let index = f1.firstIndex(of: ".")!
            
            if String(f1[index...]) == ".text" {
                FileArray.append(String(f1[..<index]))
            }
        }
    }
    
    func setupTableView() {
        FileTableView.dataSource = self
        FileTableView.delegate = self
        FileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FileCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        FileTableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.height)
        AddNewButton.frame = CGRect(x: view.width - 90, y: view.height - 100, width: 55, height: 55)
        logoutButton.frame = CGRect(x: view.width - 90, y: 20, width: 68, height: 26)
        
    }
    @objc private func checkAuth() {
        if let uname = UserDefaults.standard.string(forKey: "username") {
            //usernameLabel.text = "Welcome \(uname)"
        }
        else{
            let vc = Login()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension FileList: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
        cell.textLabel?.text = FileArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Notes"
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(FileArray[indexPath.row])
        
        let filePath = FMS.getDocDir().appendingPathComponent("\(FileArray[indexPath.row]).text")
        
        let vc = NewFile()
        vc.nameTextField.text = FileArray[indexPath.row]
        
        do {
            let EditText = try String(contentsOf: filePath, encoding: .utf8)
            vc.contentTextView.text = EditText
        } catch {
            print(error)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        let filePath = FMS.getDocDir().appendingPathComponent("\(FileArray[indexPath.row]).text")
        
        do {
            try FileManager.default.removeItem(at: filePath)
            FileArray.remove(at: indexPath.row)
            FileTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print(error)
        }
        
        
    }
    
}



