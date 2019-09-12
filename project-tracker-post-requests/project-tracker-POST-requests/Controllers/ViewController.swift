//
//  ViewController.swift
//  project-tracker-POST-requests
//
//  Created by Sunni Tang on 9/10/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
   
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var projects = [Project]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        ProjectAPIClient.manager.getProjects { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(projects):
                    self?.projects = projects
                case let .failure(error):
                    self?.displayErrorAlert(with: error)
                }
            }
        }
    }
    
    private func displayErrorAlert(with error: AppError) {
        let alertVC = UIAlertController(title: "Error Fetching Data", message: "\(error)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


extension ProjectsViewController: UITableViewDelegate {}

extension ProjectsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let project = projects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        cell.textLabel?.text = project.name
        cell.detailTextLabel?.text = project.dueDate?.description
        return cell
    }
}
