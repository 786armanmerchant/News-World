//
//  FAQViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-21.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class FAQViewController:BaseViewController{
    @IBOutlet weak var tableView: UITableView!
    
    @Published var faq = [Faq]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setDataSourceAndUI()
        setBackButton()
        setNavBarTintColor(color: #colorLiteral(red: 0, green: 0.5209681392, blue: 0.706921041, alpha: 1), titleColor: .white)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "FAQ"
        
        fetchFaq()
        
    }
    fileprivate func setDataSourceAndUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faq.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell") as? FAQTableViewCell else {
            return UITableViewCell()
        }
        
        if faq.count != 0 {
            cell.FAQ = faq[indexPath.row]
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    fileprivate func fetchFaq(){
        WNFirestore.db.collection(FirestoreKeys.faq).addSnapshotListener { querySnapshot, Error in
            guard let documents = querySnapshot?.documents else { return }
            self.faq = documents.compactMap({ (querySnapshot)-> Faq? in
               return try? querySnapshot.data(as: Faq.self)
            })
            self.tableView.reloadData()
        }
    }
}
