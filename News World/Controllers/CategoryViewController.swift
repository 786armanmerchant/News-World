//
//  CategoryViewController.swift
//  News World
//
//  Created by Mithun Karun Suma on 2022-11-26.
//

import UIKit
import SafariServices
class CategoryViewController: UIViewController {

    let tableView = UITableView()
    private var viewModels = [NewsTableViewCellModel]()
    var articles = [Article]()
    

  

   
  
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
       

        view.addSubview(tableView)
        tableView.frame = self.view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CNNCell.self,
                           forCellReuseIdentifier: "CNNCell")
        createNavMenu()
        fetchTopStories(category: "general")
        title = "General".uppercased()
        
        
    }
    

    
    
    
    
    private func fetchTopStories(category: String) {
        APICaller.shared.getTopStories(category: category){ [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellModel(title: $0.title ?? "", subtitle: $0.articleDescription ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""), ago: $0.publishedAt)
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
  

    
    
    
    private func createNavMenu() {
        let categoryImage = UIImage(systemName: "list.dash")
        let categoryBarButton = UIBarButtonItem(title: nil, image: categoryImage, primaryAction: nil, menu: categoryMenu)
        categoryBarButton.tintColor = .systemGray
        navigationItem.leftBarButtonItem = categoryBarButton
        
        //style
//        let styleImage = UIImage(systemName: "textformat.size")
//        let styleBarbutton = UIBarButtonItem(title: nil, image: styleImage, primaryAction: nil, menu: styleMenu)
//        styleBarbutton.tintColor = .systemGray
//        navigationItem.rightBarButtonItem = styleBarbutton

        
    }

    
    var categoryMenu: UIMenu {
        let menuActions = NewsCategory.allCases.map({ (item) -> UIAction in
            let name = item.rawValue
            return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemName)) { (_) in
                self.select(name)
            }
        })

        return UIMenu(title: "Change Category", children: menuActions)
    }
    
    
  
  
    
    
    
//    var styleMenu: UIMenu {
//        let menuActions = Style.allCases.map { (style) -> UIAction in
//            return UIAction(title: style.display, image: nil) { (_) in
//                self.select(style)
//            }
//        }
//
//        return UIMenu(title: "Change Style", children: menuActions)
//    }
    
   
    
//    func select(_ aStyle: Style) {
//
//
//
//    }
 
    
   
    
   
    

    
    func select(_ category: String) {
        title = category.uppercased()
        fetchTopStories(category: category)
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
    }

}


extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CNNCell", for: indexPath) as? CNNCell else {
            return UITableViewCell()
        }
        cell.model = viewModels[indexPath.row]
        
        return cell
    }
}
