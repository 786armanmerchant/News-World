//
//  AccountViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-28.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import MobileCoreServices



class AccountViewController: BaseViewController, UINavigationControllerDelegate {
    @IBOutlet weak var langaugeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImg: UIImageView!
    var account: [Account]?
    var metaData = StorageMetadata()
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var editBtn: UIButton!
    var imagePicker : UIImagePickerController = UIImagePickerController()
 


    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTintColor(color: #colorLiteral(red: 0, green: 0.5209681392, blue: 0.706921041, alpha: 1), titleColor: .white)
        hideNavBar(false, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layer.cornerRadius = 10
        imagePicker.delegate = self
        userImg.layer.cornerRadius = userImg.frame.width/2
        editBtn.setTitle("", for: .normal)
        self.navigationItem.title = "ACCOUNT".localize()
        langaugeLabel.text = "LANGUAGE".localize()
        if DataPersistance.getAppLanguage() == "en-US" {
            languageSegmentedControl.selectedSegmentIndex = 0
        } else {
            languageSegmentedControl.selectedSegmentIndex = 1
        }
        fetchUser()
    }
    
  
   
    
    @IBAction func editBtnClicked(_ sender: Any) {
        editImage()
    }
    fileprivate func fetchUser(){
        guard let email = DataPersistance.manager.getEmail() else { return }
        WNFirestore.db.collection(FirestoreKeys.accounts).whereField("email", isEqualTo: email).addSnapshotListener { querySnapshot, Error in
            guard let documents = querySnapshot?.documents else { return }
            self.account = documents.compactMap({ (querySnapshot)-> Account? in
               return try? querySnapshot.data(as: Account.self)
            })
            if self.account?.count != 0 {
                CommonUtils.setImageForDp(url: self.account?[0].dp ?? "", imageView: self.userImg)
            }
            self.tableView.reloadData()
        }
    }

    @IBAction func languageSegmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            DataPersistance.saveAppLangage(language: "en-US")
        } else {
            DataPersistance.saveAppLangage(language: "fr")
        }
        self.navigationItem.title = "ACCOUNT".localize()
        langaugeLabel.text = "LANGUAGE".localize()
        
     
    }
    fileprivate func signoutUser(){
       
    do {
        
      try Auth.auth().signOut()
        DataPersistance.manager.removeAll()
       navigateToSignIn()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    func getHeaderCell(tableView:UITableView, indexPath:IndexPath)-> AccountHeaderTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderTableViewCell", for: indexPath) as!  AccountHeaderTableViewCell
        cell.selectionStyle = .none
        
        if account?.count != nil {
            cell.dp =  account?[0].dp
        }
        cell.editButton.addTarget(self, action: #selector(editImage), for: .touchUpInside)
        return cell
    }
    @objc func editImage(){
        self.attachmentActionSheet()
    }
    func getBodyCell(tableView:UITableView, indexPath:IndexPath)->AccountDetailsTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailsTableViewCell", for: indexPath) as!  AccountDetailsTableViewCell
        cell.editButton.tag = indexPath.row
        cell.setupAccount(account: account?[0], index: indexPath.row)
        cell.editButton.addTarget(self, action: #selector(editButtonClicked(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func navigateToSignIn(){
        guard let signinVC = CommonUtils.getViewController(id: "WelcomeViewController")   as? WelcomeViewController else {
            return
        }
       let nav = UINavigationController(rootViewController:  signinVC)
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.prefersLargeTitles = true
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    @objc func editButtonClicked(sender:UIButton){
        guard let editVC = CommonUtils.getViewController(id: "EditProfileViewController")   as? EditProfileViewController else {
            return
        }
        editVC.index = sender.tag
        editVC.account = account?[0]
        editVC.delegate = self
        navigationController?.present(editVC, animated: true, completion: nil)
    }
    
    private func attachmentActionSheet(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.openSource(type: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        let actions = [galleryAction, cancelAction]
        if #available(iOS 13.0, *) {
            let actionIcons = [UIImage(systemName: "photo")]
            for (index, action) in actions.enumerated(){
                if index < actions.count - 1 {
                    action.setValue(actionIcons[index], forKey: "image")
                }
            }
        }
        actions.forEach({alert.addAction($0)})
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openSource(type: UIImagePickerController.SourceType){
        switch type {
        case .camera:
            pickImage(type: type)
        case .photoLibrary:
            pickImage(type: type)
        default:
            break
        }
    }
    private func pickImage(type: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(type) == true {
            self.imagePicker.sourceType = type
            self.imagePicker.mediaTypes = [ kUTTypeImage as String]
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            print("This facility is not available in your device")
        }
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return  indexPath.row == 0 ? getHeaderCell(tableView: tableView, indexPath: indexPath) : getBodyCell(tableView: tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            signoutUser()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 0 : UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 0 : 100
    }
    
}




extension AccountViewController: editDetailsDelegate{
    func didEditComplete(account: Account) {
        updateUserDetails(account: account)
    }
    
    func updateUserDetails(account:Account){
        let user = ["fname": account.fname ?? "Not set",
                    "lname": account.lname ?? "Not set",
                    "dp": account.dp ?? "",
                    "email": DataPersistance.manager.getEmail() ?? ""
        ]
        guard let id = account.id else { return }
       let userRef = WNFirestore.db.collection(FirestoreKeys.accounts).document(id)
        userRef.updateData(user) { err in
            if err != nil {
                print("Error updating document: \(err)")
            }
        }
    }
}
extension AccountViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.handleSelectedMedia(picker, info: info)
    }
    fileprivate func handleSelectedMedia(_ picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]){
        if #available(iOS 11.0, *) {
             if let imageURL = (info[.imageURL] as? NSURL)?.relativePath{
                let imgURL = NSURL(fileURLWithPath: imageURL)
                self.handleSelectedImage(imageURL: imgURL, picker:picker)
            }else if let capturedImg = info[.originalImage] as? UIImage{
//                let orientationFixedImage = capturedImg
                
                let pngImg = capturedImg.pngData()
                if let filePath = self.filePath() {
                    do  {
                        try pngImg?.write(to: filePath,
                                          options: .atomic)
                        guard let url = NSURL(string: filePath.relativeString) else{return}
                        self.handleSelectedImage(imageURL: url, picker:picker)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            }else{
                print("Invalid type selected")
            }
        }else {
            print("only iOS 11 or later supporting")
        }
        
    }
    private func handleSelectedImage(imageURL: NSURL, picker:UIImagePickerController?){
        picker?.dismiss(animated: true, completion: nil)
                DispatchQueue.main.async {
                    self.uploadImage(imageURL: imageURL)
                }
        }
    
    private func filePath() -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(UUID().uuidString + ".jpg")
    }
    

    fileprivate func uploadImage(imageURL: NSURL){
        let fileName = imageURL.lastPathComponent ?? NSUUID().uuidString + ".jpg"
        let folderName = "Images" +  fileName
        
       
      let ref = Storage.storage().reference().child(folderName)
       let currentUploadTask = ref.putFile(from: imageURL as URL, metadata: metaData) { (metaData, error)
            in
            if error != nil{
                print("Failed Uploading Image")
                return
            }
            let imgStorageURL: Void = ref.downloadURL(completion: { (url, error) in
                if error != nil{
                    print("Failed to get storage url")
                    return
                }
                if let filePath = url, let account = self.account?[0]{
                    self.account?[0].dp = filePath.relativeString
                    self.updateUserDetails(account: account)
                }
            })
        }
        currentUploadTask.observe(.progress) { (snapShot) in
            print(snapShot.progress)
        }
        currentUploadTask.observe(.success) { (snapShot) in
        }
        currentUploadTask.observe(.failure) { (snapShot) in
            
        }
    }
        
    }
