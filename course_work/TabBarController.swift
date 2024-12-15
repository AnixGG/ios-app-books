//
//  TabBarController.swift
//  course_work
//
//  Created by Нияз Газизуллин on 15.12.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let BooksController = BooksViewController()
        let FavoriteBooksController = FBooksViewController()
        let ProfileController = ProfileViewController()

        BooksController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "book"), tag: 0)
        FavoriteBooksController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "star"), tag: 1)
        ProfileController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [BooksController, FavoriteBooksController, ProfileController]
    }
}

