//
//  Created by Daniel on 12/12/20.
//

import UIKit

class CNNCell: UITableViewCell {

    static let identifier: String = "CNNCell"
    var articleImageView = UIImageView()
    var logo = UIImageView()

    var ago = UILabel()
    var source = UILabel()
    var summary = UILabel()
    var title = UILabel()

    
    var model: NewsTableViewCellModel? {
        didSet {
            load(model: model)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        title.font = .systemFont(ofSize: 20)
        title.textColor = .white
        
        summary.font = .systemFont(ofSize: 14)
        summary.textColor = .secondaryLabel
        
        source.textColor = .white
        source.font = UIFont.boldSystemFont(ofSize: 12)
        
        ago.textColor = .systemRed
        ago.font = .preferredFont(forTextStyle: .caption1)
        
        [articleImageView, summary, ago].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }
        
        let imageHeight: CGFloat = 220
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            summary.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset),
            summary.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset + 10),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor, constant: inset + 10),
            
            ago.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset)
        ])
        
        [source, title].forEach { item in
            articleImageView.addSubviewForAutoLayout(item)
        }
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: inset),
            articleImageView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            articleImageView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: inset),
            
            source.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: inset),
            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func convertDateToString(ago: String?) -> String?{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateStr = ago else { return nil }
        
        guard let date = formatter.date(from: dateStr) else { return nil}
        let rdf = RelativeDateTimeFormatter()
        
        return rdf.localizedString(for: date, relativeTo: Date())
    }
    
    
    
    

    func load(model: NewsTableViewCellModel?) {
        title.text = model?.title
        summary.text = model?.subTitle
        source.text = "Some source"//article.source?.name?.uppercased()
        ago.text = convertDateToString(ago: model?.ago)//article.ago

        CommonUtils.setImageFrom(url: model?.imageURL, imageView: articleImageView)
    }

}
