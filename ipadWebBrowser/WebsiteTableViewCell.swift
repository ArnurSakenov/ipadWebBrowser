//
//  TableViewCell.swift
//  ipadWebBrowser
//
//  Created by Arnur Sakenov on 30.03.2023.
//

import UIKit
import SnapKit

class WebsiteTableViewCell: UITableViewCell {

    static let reuseIdentifier = "TableCell"

    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Google"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(headerLabel)
        selectionStyle = .default
        backgroundColor = .clear

        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()

        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

