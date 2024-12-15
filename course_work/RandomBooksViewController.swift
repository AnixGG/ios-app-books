//
//  ViewController.swift
//  course_work
//
//  Created by Нияз Газизуллин on 15.12.2024.
//

import UIKit
import SnapKit

class BooksViewController: UIViewController {
    private var data: [Book] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchRandomBooks() { [weak self] books in
                    DispatchQueue.main.async {
                        self?.data = books ?? []
                        self?.tableView.reloadData()
                    }
                }
    }

}

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        cell.configureData(book: data[indexPath.row])
        
        return cell
    }
}

extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        BookCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsViewController = BookDetailController()
        detailsViewController.setBook(book: data[indexPath.row])
        navigationController?.pushViewController(detailsViewController, animated: false)
    }
}
