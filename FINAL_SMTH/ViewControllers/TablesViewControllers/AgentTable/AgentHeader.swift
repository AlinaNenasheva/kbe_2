//
//  AgentHeader.swift
//  
//
//  Created by Алина Ненашева on 10/17/20.
//

import UIKit

class AgentHeader: UITableViewHeaderFooterView {
    let agentName = UILabel()
    let passport = UILabel()
    let phone = UILabel()
    let insuranceCompany = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        agentName.translatesAutoresizingMaskIntoConstraints = false
        passport.translatesAutoresizingMaskIntoConstraints = false
        phone.translatesAutoresizingMaskIntoConstraints = false
        insuranceCompany.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(agentName)
        contentView.addSubview(passport)
        contentView.addSubview(phone)
        contentView.addSubview(insuranceCompany)
        
        NSLayoutConstraint.activate([
                   agentName.leadingAnchor.constraint(equalTo: 10),
                   agentName.topAnchor.constraint(equalTo: 10)
                   agentName.widthAnchor.constraint(equalToConstant: 50),
                   agentName.heightAnchor.constraint(equalToConstant: 50),
                   agentName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               
  
                   title.heightAnchor.constraint(equalToConstant: 30),
                   title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                          constant: 8),
                   title.trailingAnchor.constraint(equalTo:
                          contentView.layoutMarginsGuide.trailingAnchor),
                   title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
               ])
    }
}
