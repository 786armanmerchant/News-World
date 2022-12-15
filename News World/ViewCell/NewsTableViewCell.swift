//
//  NewsTableViewCell.swift
//  WorldNews
//
// Created by Arman Merchant on 2022-10-10.
//

import UIKit
 
class NewsTableViewCellModel {
    let title: String
    let subTitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    let ago: String?
    
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?,
        ago: String?
        
//        imageData: Data?
    ) {
        self.title = title
        self.subTitle = subtitle
        self.imageURL = imageURL
        self.ago = ago
//        self.imageData = imageData
    }
    
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let  newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let  subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "placeholder")
        return imageView
    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(newsImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 170, height: 70)
        
        subTitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 170, height: contentView.frame.size.height/2)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 150, y: 5, width: 140, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellModel ) {
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
       
        //image
        if let url = viewModel.imageURL {
            CommonUtils.setImageFrom(url: url, imageView: newsImageView)
                
        }
    }
}
