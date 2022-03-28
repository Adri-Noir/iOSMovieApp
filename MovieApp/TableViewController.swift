//
//  TableViewController.swift
//  MovieApp
//
//  Created by Five on 25.03.2022..
//

import Foundation
import UIKit


class TableViewController : UIViewController {
    let cellIdentifier = "cellid"
    let headerIdentifier = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        let headerView = UILabel()
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: 0,
            height: 50)
        headerView.text = "Table View Header"
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
    }
    
}

extension TableViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath) // 4.
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration() // 5.
        cellConfig.text = "Row \(indexPath.row)"
        cellConfig.textProperties.color = .purple
        cell.contentConfiguration = cellConfig
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: headerIdentifier)
        else { return nil }
        var config = header.defaultContentConfiguration()
        config.text = "Section Header"
        header.contentConfiguration = config
        return header
    }
}
