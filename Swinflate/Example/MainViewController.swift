//
//  ViewController.swift
//  Example
//
//  Created by Vlad on 1/7/19.
//  Copyright © 2019 Vlad Iacob. All rights reserved.
//

import UIKit

final class MainViewController: UITableViewController {
    // MARK: - Properties
    
    private var examples: [SwinflateExamples] = []
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Swinflate"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        tableView.delegate = self
        tableView.dataSource = self
        
        examples = SwinflateExamples.allCases
    }
}

// MARK: - UITableViewDataSource

extension MainViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.text = examples[indexPath.row].rawValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(examples[indexPath.row].viewController, animated: true)
    }
}
