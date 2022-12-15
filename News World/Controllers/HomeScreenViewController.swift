//
//  HomeScreenViewController.swift
//  WorldNews
//
// Created by Arman Merchant on 2022-10-10.
//

import UIKit
import SafariServices

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        
        createNavMenu()
        navigationItem.hidesBackButton = true
      
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        
        
        fetchTopStories(country: "in")
        createSearchBar()
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "NEWS".localize()
        
    }

    
//    @objc func openCategoryMenu() {
//
//        let
//        let alert = UIMenu(children:[])//UIAlertController(title: "Category", message: "", preferredStyle: .)
//        alert.addAction(UIAlertAction(title: "Sports", style: .default))
//        alert.addAction(UIAlertAction(title: "News", style: .default))
//        self.present(alert, animated: true)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        
    }
    
    
    
    private func fetchTopStories(country: String) {
        APICaller.shared.getTopStories(country: country){ [weak self] result in
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
    
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // Search Functionality
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
       
            APICaller.shared.search(with: text) { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.viewModels = articles.compactMap({
                        NewsTableViewCellModel(title: $0.title ?? "", subtitle: $0.articleDescription ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""), ago: $0.publishedAt)
                        
                    })
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.searchVC.dismiss(animated: true, completion: nil)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            
            
            print(text)
        }
    }
    
    
    private func createNavMenu() {
        let categoryImage = UIImage(systemName: "globe.badge.chevron.backward")
        let categoryBarButton = UIBarButtonItem(title: nil, image: categoryImage, primaryAction: nil, menu: countryMenu)
        categoryBarButton.tintColor = .systemGray
        navigationItem.rightBarButtonItem = categoryBarButton
        
        //style
      

        
    }

    
    var countryMenu: UIMenu {
        let menuActions = NewsCountry.allCases.map({ (item) -> UIAction in
            let name = item.rawValue
            let countryName = item.systemName
            return UIAction(title: countryName.capitalized, image: UIImage(systemName: item.systemName)) { (_) in
                self.select(name)
            }
        })

        return UIMenu(title: "Change Country", children: menuActions)
    }
    
    func select(_ country: String) {
        //title = "News - \(country.uppercased())"
        fetchTopStories(country: country)
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        fetchTopStories(country: "in")
    }
}
